<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑장 소개</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/basic.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/infoPage.css" />
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
		<div id="info">
			<div id="infoCont">
				<h1>슬기로운 캠핑생활 캠핑장 소개</h1>
				<p>'슬기로운 캠핑생활'은 대전광역시 내에 위치하여 접근이 편리합니다. 산에 자리 잡고 있어 산림의 아름다운 절경과
					자연 속에서의 휴양과 힐링을 경험할 수 있습니다. 새로운 모험과 평화로운 휴식을 원하는 모든 캠핑 애호가에게 적합한
					곳입니다. 자연 속에서의 최상의 경험을 즐기실 수 있을 것입니다.</p>
			</div>

			<div id="autoCamp">
				<h3>오토캠핑장</h3>
				<p>Auto Camp Site</p>
				<p>우리 캠핑장의 오토캠핑장은 휴식과 자연을 만끽하며 편안한 캠핑을 즐길 수 있는 곳입니다. 차량으로 쉽게 접근할
					수 있어 편리한 위치에 자리하고 있으며, 자연의 소리와 아름다운 풍경을 경험하며 휴식을 취할 수 있습니다.</p>
			</div>
			<div id="glamping">
				<h3>글램핑</h3>
				<p>Glamping</p>
				<p>우리의 고급 글램핑 시설은 캠핑의 본질을 유지하면서도 고급 휴식을 제공합니다. 고급 편의시설과 특별한 분위기를
					즐기고자 하는 분들을 위한 글램핑 옵션이 제공됩니다. 편안한 침실과 아름다운 자연 환경을 동시에 즐길 수 있습니다.</p>
			</div>
			<div id="caravan">
				<h3>카라반</h3>
				<p>Caravan</p>
				<p>이동식 카라반으로 캠핑을 즐기는 분들을 위한 전용 지역이 마련되어 있습니다. 캠핑의 모험을 살면서도 편안함을
					느낄 수 있습니다.</p>
			</div>
		</div>
	</section>
	<footer id="footer"></footer>
</body>
</html>