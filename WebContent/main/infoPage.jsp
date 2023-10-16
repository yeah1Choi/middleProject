<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/basic.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/infoPage.css" />
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<script>
$(function(){
	$("#header").load("<%=request.getContextPath()%>/main/header.jsp");
	$("#footer").load("<%=request.getContextPath()%>/main/footer.jsp");
})
</script>
</head>
<body>
	<header id="header"></header>
	<section>
		<!-- 메뉴타이틀 & 배경 -->
		<div id="mapback">
			<h1>캠핑장 소개</h1>
			<img src="../images/imageSlide02.jpg" alt="" />
		</div>
		<div id="info"></div>
	</section>
	<footer id="footer"></footer>
</body>
</html>