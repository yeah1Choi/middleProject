<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 :: 회원 정보 조회</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/basic.css" />

<style type="text/css">
html {
	height: 100%;
}
body {
	height: 100%;
	box-sizing: border-box;
}
header {
	width: 100%;
	padding: 15px 10%;
	display: flex;
	flex-direction: row;
    justify-content: space-between;
    background: #d6d46d;
}
header * {
    color: #4d2222;
}
header>p {
	font-size: 25px;
	line-height: 50px;
}
header span {
	padding: 12px 0;
}
header #log {
	display: flex;
	flex-direction: row;
}
#logsearch {
	display: flex;
	flex-direction: row;
	position: relative;
}
#logsearch input {
	width: 0;
	visibility: hidden;
	margin: auto 3px;
	padding: 7px 10px;
	position: absolute;
	top: 13px;
	left: 150%;
	transform: translateX(-150%);
	transition: all 0.5s;
	border: 1px solid #9A4444;
	border-radius: 10px;
}
#logsearch input.on {
	width:  130px;
	visibility: visible;
	display: inline-block;
}
.symbol {
	cursor: pointer;
	margin-left: 20px;
}
header span.material-symbols-outlined {
	font-size: 30px;
}
#container {
	width: 100%;
	height: 100%;
	display: flex;
}
#sidemenu {
	height: 100%;
	flex: 18%;
	background: #f1f0cb;
	padding: 2%;
	overflow: hidden;
}
#sidemenu * {
    color: #4d2222;
}
#sidemenu a {
    font-size: 1rem;
}
#sidemenu h3 {
	font-size: 18px;
	font-weight: bolder;
	display: inline-block;
	position: absolute;
	top: 10px;
	left: 50px;
	margin: 0;
}
#section {
	flex: 82%;
	background: #fff;
}
.submenu {
	position: absolute;
	top: 30px;
	left: 40px;
}
#sidemenu .lif {
	height: 130px;
	position: relative;
}
.lif > span {
	position: relative;
	top: 7px;
	left: 0;
}
.submenu li {
	margin: 20px 10px;
	position: relative;
}
.submenu li a {
	position: inherit;
	z-index: 10;
	transition: all 0.4s;
	cursor: pointer;
}
.submenu li:hover a{
	color: #f1f0cb !important;
}
.submenu li span {
	transition: all 0.5s;
}
#second {
	margin-bottom: 70px;
}
span.bck {
    display: inline-block;
    background: #4d2222;
    width: 400%;
    height: 39px;
    position: absolute;
    top: -13px;
    left: -100%;
    z-index: 1;
}
</style>
<!-- ** memberList CSS ** -->
<style type="text/css">
section * {
    color: #4d2222;
}
h1 {
    text-align: center;
    margin: 40px 0;
}
#listhead {
	display: flex;
	flex-direction: row;
    justify-content: space-between;
    width: 70%;
    margin: 20px auto;
}
input[type="button"] {
    background: #f1f0cb;
    padding: 10px 15px;
    border-radius: 30px;
    border: none;
}
#memList p span {
    color: #DE8F5F;
    margin-left: 10px;
    font-size: 14px;
    line-height: 16px;
}
select#searchType, #searchMem {
	padding: 7px 10px;
	
}
#listright {
	margin-left: 10px;
}
#listBox {
	width : 80%;
	margin : 0 auto;
	border-top: 1px solid #4d2222;
	border-bottom: 1px solid #4d2222;
}
/* 페이징 처리 시 CSS */
.page-link{
	color: black;
	border: 1px solid #ffffff; 
	margin: 0px 3px;
	font-weight:bold;
}
#prev, #next{
	color: #ffffff;
	background-color: #4d2222;
	border-color: #ffffff;
}
#prev{
	border-top-left-radius: 30px;
	border-bottom-left-radius: 30px;
}
#next{
	border-top-right-radius: 30px;
	border-bottom-right-radius: 30px;	
}
.page-link:focus, .page-link:hover {
	color: black;
}
.list {
	display: flex; 
	flex-direction: row;
	padding: 18px;
	border-bottom : 2px solid #d6d46d;
	text-align: center;
}
.list li:first-child {
	flex: 10%;
}
.list li:nth-child(2), .list li:nth-child(3) {
	flex: 20%;
}
.list li:nth-child(4), .list li:nth-child(5) {
	flex: 25%;
}
#firlist {
	border: 1px solid;
	background: #d6d46d;
}
#listBox hr {
	height: 1px;
	background: #d6d46d;
	opacity: 0.7;
}
</style>

</head>
<body>
	<!-- 헤더 -->
	<header id="header">
		<div id="logo">
			<img alt="" src="<%=request.getContextPath()%>/images/perm_logo.png">
		</div>
		<p>슬기로운 캠핑생활 캠핑장 관리자 프로그램</p>
		<div id="log">
			<div id="logsearch">
				<input type="text" placeholder="검색어 입력">
				<p id="searchbtn" title="검색">
					<span class="material-symbols-outlined symbol">search</span>
				</p>
			</div>
			<p title="로그아웃">
				<span class="material-symbols-outlined symbol">logout</span>
			</p>
			<p title="이용자사이트로가기">
				<a href="<%=request.getContextPath()%>/main/mainPage.jsp"><span
					class="material-symbols-outlined symbol"> home </span></a>
			</p>
		</div>
	</header>
	<!-- 헤더 아래 모두 -->
	<div id="container">
		<div id="sidemenu">
			<ul>
				<li class="lif">
					<span class="material-symbols-outlined">person</span>
					<h3>
						회원 관리
					</h3>
					<ul class="submenu">
						<li><span></span><a class="alink" data-url="<%=request.getContextPath()%>">회원 정보 조회</a></li>
					</ul>
				</li>
				<li class="lif">
					<span class="material-symbols-outlined">camping</span>
					<h3>
						캠핑장 예약 관리
					</h3>
					<ul class="submenu">
						<li><span></span><a class="alink" data-url="<%=request.getContextPath()%>/admin/adminResMain.jsp">예약 현황 조회</a></li>
					</ul>
				</li>
				<li class="lif" id="second">
					<span class="material-symbols-outlined">assignment</span>
					<h3>
						게시판 관리
					</h3>
					<ul class="submenu">
						<li><span></span><a class="alink" data-url="<%=request.getContextPath()%>/admin/adminReview.jsp">이용후기 게시판 댓글 관리</a></li>
						<li><span></span><a class="alink" data-url="<%=request.getContextPath()%>">FAQ 게시판</a></li>
						<li><span></span><a class="alink" data-url="<%=request.getContextPath()%>">공지사항 게시판</a></li>
					</ul>
				</li>
				<li class="lif">
					<span class="material-symbols-outlined">paid</span>
					<h3>
						매출 관리
					</h3>
					<ul class="submenu">
						<li><span></span><a class="alink" data-url="<%=request.getContextPath()%>/admin/sale.jsp">날짜별 매출 조회</a></li>
					</ul>
				</li>

			</ul>
		</div>
		<!-- **만든 것 넣기 부분** -->
		<div id="section">
			<section id="memList">
				<h1>회원 정보 조회</h1>
				<div id="listhead">
					<div>
						<p>검색결과 |  <span>총 </span><span id="searchCnt"></span><span> 명</span></p>
					</div>
					<form id="listright">
						<select id="searchType">
							<option value="">전체</option>
							<option value="mem_id">아이디</option>
							<option value="mem_name">이름</option>
							<option value="mem_mail">메일</option>
							<option value="mem_hp">전화번호</option>
						</select>
						<input type="text" placeholder="검색어를 입력" id="searchMem">
						<input type="button" value="검색">
					</form>
				</div>
				<div id="listBox">
					<ul id="firlist" class="list">
						<li>번호</li>
						<li>아이디</li>
						<li>이름</li>
						<li>이메일</li>
						<li>전화번호</li>
					</ul>
					<!-- 스크립에 쓸 것 -->
					<ul class="list">
						<li>번호</li>
						<li>아이디</li>
						<li>이름</li>
						<li>이메일</li>
						<li>전화번호</li>
					</ul>
					
					<ul class="list">
						<li>번호</li>
						<li>아이디</li>
						<li>이름</li>
						<li>이메일</li>
						<li>전화번호</li>
					</ul>
					<ul class="list">
						<li>번호</li>
						<li>아이디</li>
						<li>이름</li>
						<li>이메일</li>
						<li>전화번호</li>
					</ul>
					<ul class="list">
						<li>번호</li>
						<li>아이디</li>
						<li>이름</li>
						<li>이메일</li>
						<li>전화번호</li>
					</ul>
				</div>
				
				<nav>
				  <ul class="pagination justify-content-center">
					    <li class="page-item">
					      <a id="prev" class="page-link" href="#">prev</a>
					    </li>
					    <li class="page-item"><a class="page-link" href="#">1</a></li>
					    <li class="page-item"><a class="page-link" href="#">2</a></li>
					    <li class="page-item"><a class="page-link" href="#">3</a></li>
					    <li class="page-item"><a class="page-link" href="#">4</a></li>
					    <li class="page-item"><a class="page-link" href="#">5</a></li>
					    <li class="page-item">
					      <a id="next" class="page-link " href="#">next</a>
					    </li>
				  </ul>
				</nav>
			</section>
		</div>
	</div>
</body>
</html>