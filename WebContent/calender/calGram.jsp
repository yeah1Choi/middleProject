<%@page import="kr.or.ddit.vo.RsvVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글램핑 예약하기</title>

<!-- 스크립트 순서 제발 변경 하지말아주세요 -->

<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet'/>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
  
<!-- 모달 스크립트 -->  
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script> 
    
<!-- Bootstrap CDN (Make sure you have Bootstrap CSS and JS included) --> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 


<!-- 카카오페이 API 스크립트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

  
<script>

let campCode = "G";

function ajaxProc(){
	resdata = null;
	$.ajax({
		url : '<%= request.getContextPath()%>/selectCampno.do',
		type : 'get',
		async : false,
		data : {'campCode': campCode },
		success : function(res){
			console.log("res",res)
			resdata = res;
// 			viewCalendar(resdata);
			
			let viewData = [];

			let startDate = new Date("2023-09-01"); // 시작 날짜 설정
			let endDate = new Date("2023-11-01"); // 종료 날짜 설정
			
			while(startDate <= endDate) {
				
				let formattedDate = startDate.toISOString().split('T')[0];
				
				$.each(resdata, function(i,v){
					let data =  {
						      title: v.campsite_no,
						      start: formattedDate,
						      backgroundColor: "green",
						      borderColor: "green"
						  } 
					
					viewData.push(data);
				})
					startDate.setDate(startDate.getDate() + 1);
					
					viewCalendar(viewData);
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType  : 'json'
		
	})
	return resdata;
}
    
ajaxProc();

function viewCalendar(getData){
	
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko', // 한국어 설정
            headerToolbar: {
                start: '',
                center: 'prev title next',
                end: 'dayGridMonth,dayGridWeek,dayGridDay'
            },
            selectable: true,
            droppable: true,
            editable: true,
            events: getData
   		
        });

        calendar.render();
    });
}


//버튼 클릭했을  때 모달 띄우기!!!!!!!!
$(document).ready(function() {
    // fc-daygrid-event-harness 클래스는 웹페이젱서 F12 눌렀을 때만 보임
    $(document).on("click", ".fc-daygrid-event-harness", function() {
        // 버튼 클릭시 예약화면 모달 열리게 하기
    	$('#resModal').modal('show');
    });
});

function validateAndProceed() {
    var peoplenum = document.getElementById('peoplenum').value;
    var exitday = document.getElementById('exitday').value;

    if (peoplenum === '선택하세요' || exitday === '선택하세요') {
      alert('옵션을 모두 선택하세요.');
    } else {
      // 다음 단계로 진행합니다 (결제 모달 열기)
      $('#resModal').modal('hide');
      requestKakaoPay();
      //$('#payModal').modal('show'); */
      //window.location.href = 'paytest.html';
    }
  }

  // 카카오페이 결제를 요청하는 함수
  function requestKakaoPay() {
    var IMP = window.IMP;
    IMP.init('imp43234711'); // 귀하의 식별자로 초기화하세요

    // 결제 요청
    IMP.request_pay({
      pg: "kakaopay.TC0ONETIME",
      pay_method: 'card',
      merchant_uid: 'merchant_' + new Date().getTime(),
      name: '결제',
      amount: 100,  // 필요에 따라 금액을 조정하세요
      buyer_email: '구매자 이메일',
      buyer_name: '구매자 이름',
      buyer_tel: '구매자 번호',
      buyer_addr: '구매자 주소',
      buyer_postcode: '구매자 우편번호',
      m_redirect_url: 'http://www.naver.com'
    }, function (rsp) {
      if (rsp.success) {
        console.log('결제가 완료되었습니다.');
        console.log('결제금액: ' + rsp.amount + '원');
        console.log('구매자 정보: 이메일 - ' + rsp.buyer_email + ', 전화번호 - ' + rsp.buyer_tel);
        location.href = 'reservationSuccess.html'; // 다음 단계로 리디렉션
      } else {
        console.log('결제에 실패하였습니다.');
        console.log('에러 메시지: ' + rsp.error_msg);
        console.log('결제금액: ' + rsp.amount + '원');
        console.log('상품명: ' + rsp.name);
        console.log('구매자 정보: 이메일 - ' + rsp.buyer_email + ', 전화번호 - ' + rsp.buyer_tel);
      }
    });
  }



/*
 {
      id: 2,
      title: "Birthday Party",
      start: "2020-04-08T07:00:00",
      backgroundColor: "green",
      borderColor: "green",
      extendedProps: { status: "wholeleel" }
  } 
 
 
 */
  
</script>
<style type="text/css">
@font-face {
	font-family: "NPSfontBold";
	src:
		url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2310@1.0/NPSfontBold.woff2")
		format("woff2");
	font-weight: 700;
	font-style: normal;
}

#calendar {
	font-family: "NPSfontBold", "Malgun Gothic", "굴림", "Gulim", "Arial";
}

#calendar h2, #calendar a {
    color: #4d2222;
}
#calendar h2 {
	line-height: 50px;
}
.fc-header-toolbar {
    justify-content: center !important;
}
 
.fc-header-toolbar > div:nth-child(2) {
	display: flex;
}
.fc-header-toolbar > div:last-child {
	display: none;
}
.fc .fc-daygrid-day-top {
	margin-left: 5px;
	margin-top: 5px;
    flex-direction: row;
}

/* 기존에 button에 적용하면 모달의 button까지 적용 되므로 홈페이지 내 F12 확인하여 버튼 클래스에 적용 */
.fc-button {
	background: #f1f0cb !important;
	border: none !important;
}
button span {
    color: #4d2222;
}


/* 모달을 위한 스타일 추가 */
 @font-face {
    font-family: 'NPSfontBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2310@1.0/NPSfontBold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
html, body {
    font-family: 'NPSfontBold';
}
label{
	display : inline-block;
	width : 100px;
	height : 25px;
}
#res1 select {
  width: 58%;
  height : 25px;
}
.modal-footer{
	display: flex;
    justify-content: center;
}
#res2 span{
	color: red;
}
iframe {
	width: 100%;
	height: 100%;
	padding: 10px;
	border: 1px dotted;
	box-sizing: border-box;
	display: flex;
    justify-content: center;
    margin: 0 auto;
}
.modal-body{
	display: flex;
    justify-content: center;
}
.left{
	font-size : 10pt;
}
/* 모달창 크기 및 간격 조정 */
#res1, #res2{
	border : 1px dotted;
	height : 300px;
	width : 50%;
	float : left;
	padding: 20px;
}
/* 모달창 하단 버튼 */
#bottom{
	margin: auto;
	display:block;
	padding: 20px 0;
	text-align: center;
	color: !important;
}


</style>
</head>
<body>


<div id='calendar'>

</div>


<!-- 캘린더 내의 예약 가능한 캠핑장 유형 클릭했을 때 나오는 예약화면 모달 -->
<div class="modal fade" id="resModal" >
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">


      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">예약하기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      

		      	<!-- 예약화면 좌측 -->
		       	<div id="res1">
		       		<form>
			       		<label>예약날짜 : </label>
						<input type="text" name="resday" value="2023.10.11">
						<br>
						
						<label>캠핑장 유형 : </label>
						<input type="text" name="camptype" value="글램핑(G)">
						<br>
						
						<label>자리 번호 : </label>
						<input type="text" name="campnum" value="001">	
						<br>
						
						<label>인원수 : </label>
							<select name="peoplenum" id="peoplenum" required>
							  <option value="선택하세요" disabled selected>선택하세요</option>
							  <option value="2">2</option>
							  <option value="2">3</option>
							  <option value="4">4</option>
							</select>
						
						<br>
						
						<label id="내용">입실일 :</label>
						<input type="text" name="campnum" value="2023.10.25.">
						<br>
						
						<label>퇴실일 : </label>
							<select name="exitday" id="exitday" required>
							  <option value="선택하세요" disabled selected>선택하세요</option>
							  <option value="2023.10.26.">2023.10.26.</option>
							  <option value="2023.10.27.">2023.10.27.</option>
							</select>
						<br>
						
						<label>금액 : </label>
						<input type="text" name="money" value="200,000원">
						<br>
		       		</form>
		       		
		       	</div>
		       
		       <!-- 예약화면 우측 -->
		       	<div id="res2">
		       		<form>
		       			<p>
		       			<span>※ 예약 전 주의사항</span><br>
						- 기준 인원 2명, 최대 4명 입니다.<br>
						- 1인 당 추가요금은 10,000원 입니다.<br>
						- 연박 가능 일수는 최대 2일 입니다.<br>
						  (ex. 입실: 2023.10.01 -> 퇴실: 2023.10.03 까지<br>
						</p>	
		       		</form>
		       		
		       		<br>
		       		
		       		<form>
		       			<p>
		       			 <span>[ 객 실 정 보 ]</span><br>
						 - 숙박 입실 : 오후 3시 퇴실 오전 11시<br>
						 - 이용시설 : 화장실과 샤워실은 실외 이용<br>
						 - 취사여부 : 개인취사가능<br>
						</p>	
		       		</form>
		       	
		       	</div>
       	      
      
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">	
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
        <!-- data-bs-toggle="modal" data-bs-target="#payModal" 때문에 애썼다.. 주의하기.. -->
        <button type="button" class="btn btn-primary" id="paybtn" onclick="validateAndProceed()">다음 단계</button>
        <!-- data-bs-toggle="modal" data-bs-target="#payModal"  -->
      </div>

    </div>
  </div>
</div>

</body>
</html>