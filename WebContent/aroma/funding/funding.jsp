<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-latest.js"></script>  
 

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Funding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
</head>
<body>
<jsp:include page="../top1.jsp" />
	
	<section class="product_description_area">
		<div class="container">
            <!-- Start 카테고리 메뉴 선택 Bar -->
            
			<ul class="nav nav-tabs" id="myTab" role="tablist" onclick="getSelectInfo()">
                <li class="nav-item">
                    <a class="nav-link active" value="0" name="All" data-toggle="tab" href="#home" role="tab" aria-controls="home" 
                    aria-selected="false">전체</a>
                </li>
				<li class="nav-item">
					<a class="nav-link" value="100" name="Appliances" id="Appliances" data-toggle="tab" role="tab" aria-controls="profile"
					 aria-selected="false" >가전제품</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" value="200" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
					 aria-selected="false">패션</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" value="300" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
					 aria-selected="false">영유아 용품</a>
				</li>
                <li class="nav-item">
                    <a class="nav-link" value="400" id="food" data-toggle="tab" href="#review" role="tab" aria-controls=""
                     aria-selected="false">식품</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" value="500" id="Hobby" data-toggle="tab" href="#review" role="tab" aria-controls=""
                     aria-selected="false">뷰티</a>
                </li>
			</ul>
              <!-- End 카테고리 메뉴 선택 Bar -->
            
            <!-- Start 정렬 Bar -->
          <div class="filter-bar d-flex flex-wrap align-items-center" style="background-color: white; margin-left: -20px;">
            <div>
              <div class="input-group filter-bar-search" style="margin-right: 10px;">
              <div id="input_div">
                <input type="text" placeholder="제목으로 검색" id="input" value="">
              </div>  
                <script type="text/javascript">
                var timer;
                var text;
                var category=0;
                var sortVal=0;
                var statusVal=0;
                var categoryText;
                $(function(){
                	$('.nav-item').click(function(){
                		category = $(this).find('a').attr('value');
                		categoryText = $(this).children().text();
                	}); 
                });
                function getSelectInfo(){
                	document.getElementById("input").value = null;		
                	var sort = document.getElementById("funding_sort");
                	sortVal = sort.options[sort.selectedIndex].value;
                	var status = document.getElementById("funding_status");
                	statusVal = status.options[status.selectedIndex].value;
                	console.log("val : "+statusVal);
                	console.log("sort : "+sortVal);
                	console.log("cate:"+category);
                	console.log("text : "+text);
                	
                   	
                	var data = {category:category, statusVal:statusVal, sortVal:sortVal} 
                	 $.ajax({
                          type: 'post',
                          url: 'FundingListAjax.do',
                          data: JSON.stringify(data), 
                          contentType: "application/json; charset=utf-8",
                          dataType: "json" 
                       }).done(function(result) {
                       	var list = result;
                       	var tb='';
                       	
                          
                        $.each(list, function(j){
                      	 	tb += '<table style="float: left; width: 257px; height: 200px; margin : 10px">'
                      	  	tb += '<tr>';
                       		tb += '<td><img src="img/'+list[j].mainImg+'" style="width: 100%" height="120px"></td>';
                       		tb += '</tr>';
                       		tb += '<tr>';
                       		tb += '<td><b>'+list[j].title+'</b></td>';
                       		tb += '</tr>';
                       		tb += '<tr>';
                       		tb += '<td style="font-size: 3px">';
                       		if(list[j].categoryId == 100){
                       			tb += '가전제품';
                       		}else if(list[j].categoryId == 200){
                       			tb += '패션';
                       		}else if(list[j].categoryId == 300){
                       			tb += '영유아 용품';
                       		}else if(list[j].categoryId == 400){
                       			tb += '식품';
                       		}else if(list[j].categoryId == 500){
                       			tb += '뷰티';
                       		}
                       		tb += ' | '+list[j].makerId+'</td>';
                       		tb += '</tr>';
    						  	tb += '<tr align="right">';
    		            		tb += '<td style="font-size: 3px">';
    		            		tb += list[j].endDate;
    							tb += '마감</td>';
    		            		tb += '</tr>';
                       		
                       		tb += '</table>';
                      
                       		$("#choice").text(categoryText);
                       		
                       		
                       	});	 
                        		$("#funding_list").html(tb);
                        		
                        		
                     }).fail(function() {
                        console.log("fail");
                     }); 
                }
                
             	document.querySelector('#input').addEventListener('input', function(e) {
                  if (timer) {
                    clearTimeout(timer);
                  }
                  timer = setTimeout(function() {
                	text= e.target.value;
                	console.log("text : "+text);
               	console.log("val : "+statusVal);
               	console.log("sort : "+sortVal);
               	console.log("cate:"+category);
                	 
                	 var data = {category:category, statusVal:statusVal, sortVal:sortVal, text:text} 
              	 $.ajax({
                        type: 'post',
                        url: 'FundingTextList.do',
                        data: JSON.stringify(data), 
                        contentType: "application/json; charset=utf-8",
                        dataType: "json" 
                     }).done(function(result) {
                  	var list = result;
                      var tb='';
                      var time='';
                        
                      $.each(list, function(j){
                      	tb += '<table style="float: left; width: 257px; height: 200px; margin : 10px">'
                      	tb += '<tr>';
                       	tb += '<td><img src="img/'+list[j].mainImg+'" style="width: 100%" height="120px"></td>';
                   		tb += '</tr>';
                   		tb += '<tr>';
                   		tb += '<td><b>'+list[j].title+'</b></td>';
                   		tb += '</tr>';
                   		tb += '<tr>';
                   		tb += '<td style="font-size: 3px">';
                   		if(list[j].categoryId == 100){
                   			tb += '가전제품';
                   		}else if(list[j].categoryId == 200){
                   			tb += '패션';
                   		}else if(list[j].categoryId == 300){
                   			tb += '영유아 용품';
                   		}else if(list[j].categoryId == 400){
                   			tb += '식품';
                   		}else if(list[j].categoryId == 500){
                   			tb += '뷰티';
                   		}
                   		tb += ' | '+list[j].makerId+'</td>';
                   		tb += '</tr>';
                   		tb += '<tr align="right">';
		            		tb += '<td style="font-size: 3px">';
		            		tb += list[j].endDate;
							tb += '마감</td>';
		            		tb += '</tr>';
                   		tb += '</table>';
                  
                   		$("#choice").text(categoryText);
                   	});	 
                    		$("#funding_list").html(tb);
                        
                     }).fail(function() {
                        console.log("fail");
                     }); 
                	 
                  }, 200);
                 
                }); 
                </script>

                <div class="input-group-append">
                  <button type="button"><i class="ti-search"></i></button>
                </div>
              </div>
            </div>
            <div class="sorting">
              <select id="funding_status"  onchange="getSelectInfo()">
                <option value="0">진행중</option>
                <option value="1">종료된</option>
              </select>
            </div>
            <div class="sorting mr-auto" >
              <select id="funding_sort" onchange="getSelectInfo()">
                <option value="0">최신순</option>
                <option value="1">인기순</option>
                <option value="2">펀딩액순</option>
                <option value="3">마감임박순</option>
              </select>
            </div>
          </div>
         
         <!-- Start 리스트 -->
        <section class="related-product-area section-margin--small mt-0" >
        	<div class="container" style="margin-top: -70px">
            	<div class="section-intro pb-60px">
		         <h2 class="section-intro__style" align="right" id="choice">전체</h2>
				</div>
            <div class="row mt-60">
	            <div  id="funding_list">
	            <c:forEach var="v" items="${v}">
	            <table style="float: left; width: 257px; height: 200px; margin : 15px">
	            	<tr>
	            		<td><img src="img/${v.mainImg }" style="width: 100%" height="120px"></td>
	            	</tr>
	            	<tr>
	            		<td><b>${v.title }</b></td>
	            	</tr>
	            	<tr>
	            		<td style="font-size: 3px">
	            		
	            		    <c:if test="${v.categoryId eq 100}">가전제품</c:if>
		          			<c:if test="${v.categoryId eq 200}">패션</c:if>
		          			<c:if test="${v.categoryId eq 300}">영유아 용품</c:if>
		          			<c:if test="${v.categoryId eq 400}">식품</c:if>
		          			<c:if test="${v.categoryId eq 500}">뷰티</c:if> 
	            		
	            			| ${v.makerId }
	            		</td>
	            	</tr>
	            	<tr align="right">
	            		<td style="font-size: 3px">
		            		<c:set var="now" value="<%=new java.util.Date()%>" />
							<fmt:formatDate value="${now}" var="nowtime" pattern="yyyy-MM-dd" />
							<fmt:parseDate value="${v.endDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
							<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
							<fmt:parseDate value="${nowtime}" var="endPlanDate" pattern="yyyy-MM-dd"/>
							<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
							${ strDate - endDate}일 남음
						</td>
	            	</tr>
	            </table>
	            </c:forEach>
	            <!-- <tr id='addbtn'>
	            	<td colspan="4">
	            		<divclass="btns"><a href="javascript:moreList();" class="btn btn-primary">더보기</a>
	            	</td>
	            </tr> -->
	            </div>
            </div>
            
    <script >
	function moreList(){
	    $.ajax({
	        url :"/admin/jsonlist",
	        type :"POST",
	        cache : false,
	        dataType:'json',
	        data :"conectType="+conectType +"&eDate="+eDate+"&sDate="+sDate+"&codeId="+codeId+"&limit="+limit,
	        success :function(data){
	            //console.log(data);
	            var content="";
	            for(var i=0; i<data.hashMapList.length; i++){
	                content +=
	                "<tr>"+
	                    "<td>"+data.hashMapList[i].area+"</td>"+
	                    "<td>"+data.hashMapList[i].name+"</td>"+
	                    "<td>"+data.hashMapList[i].gubun+"</td>"+
	                    "<td>"+data.hashMapList[i].cnt+"</td>"+
	                "</tr>";
	            }
	            content+="<tr id='addbtn'><td colspan='5'><div class='btns'><a href='javascript:moreList();' class='btn'>더보기</a></div>  </td></tr>";
	            $('#addbtn').remove();//remove btn
	            $(content).appendTo("#table");
	        }, error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }
	    });
	};
	</script>
            
            </div>
    	</section>
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