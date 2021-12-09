<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
  <title>GoodFunding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.7/css/swiper.min.css'>
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css'>
  <link rel="stylesheet" href="vendors/swiper/style.css">
 <!--  <link href="https://fonts.googleapis.com/css?family=Rajdhani&display=swap" rel="stylesheet"> -->

</head>
<body>	
  <jsp:include page="top1.jsp" />

  <main class="site-main">
	<c:set var="center" value="${param.center}"/>
	<c:if test = "${center == null}">
		<c:set var="center" value="center.jsp"/>
	</c:if>
	<jsp:include page="${center}"/>
	
  </main>
  <jsp:include page="bottom.jsp" />

  <script src='https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js'></script>
  <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>
  <script  src="vendors/swiper/script.js"></script>

</body>
</html>