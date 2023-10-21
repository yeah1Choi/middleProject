<%@page import="kr.or.ddit.vo.RsvVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fullcalendar CDN -->
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css'
	rel='stylesheet' />
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>

<%
	String campCode = request.getParameter("campCode");
%>

<script>
let calendar = null;
<%-- 
/* 캠핑타입 버튼 클릭 이벤트 */
$(document).on('click', '.resbtn', function(){
	campCode = $(this).attr('txt').trim();
	
	$.ajax({
		url : "<%= request.getContextPath() %>/selectCampno.do",
		data : {"campCode": campCode},
		type : "get",
		success : function(res){
			getData = 
		}
	})
}) 
--%>
let campCode = "<%=campCode%>";
let formattedDate = [];
let viewData = [];
function ajaxProc(){
	resdata = null;
	$.ajax({
		url : '<%=request.getContextPath()%>/selectCampno.do',
		type : 'get',
		async : false,
		data : {'campCode': campCode },
		success : function(res){
			console.log("res",res)
			resdata = res;
// 			viewCalendar(resdata);

			let startDate = new Date("2023-09-01"); // 시작 날짜 설정
			let endDate = new Date("2023-11-01"); // 종료 날짜 설정
			
			while(startDate <= endDate) {
				
				formattedDate = startDate.toISOString().split('T')[0];
				
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
			}
			
			viewCalendar(viewData);
			
			
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType  : 'json'
		
	})
	return resdata;
}

$(function(){
	ajaxProc();
	
});

function viewCalendar(getData){
	
/*     if (calendar) {
        calendar.destroy(); // 기존 캘린더 객체 제거
    } */
	
//     document.addEventListener('DOMContentLoaded', function() {
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
            editable: false,
            events: getData
   		
        });

        calendar.render();

//     });
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

 
 
/*   
$(function(){
    $(document).on('click', '.resbtn', function(){
    	campCode = $(this).attr('txt').trim();
    	console.log(campCode);
    	ajaxProc();
    });
	
});    
*/

function dateFormat(){
	console.log("calendar++++", calendar.currentData.currentDate)
	let currDate = new Date(calendar.currentData.currentDate)
	var yyyy = currDate.getFullYear().toString();
    var mm = (currDate.getMonth() + 1).toString();
    var dd = currDate.getDate().toString();
    return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
}

$(function(){
	
// console.log("viewData : "+viewData);
// viewData = [{title: 'G-001', start: '2023-09-01'}, ...]

// 예약 상태 확인 후 출력
resdata = null;

// console.log("calendar++++", calendar.currentData.currentDate)
// console.log("cudate", dateFormat())

$.ajax({
	url : "<%=request.getContextPath()%>/checkFlag.do",
	data : { 'currMonth': dateFormat().substring(0,7),
			 'campCode': campCode
			 
	       }, // viewData를 서버로 전송
	type : "post",
	traditional : true,
	success : function(res){
		console.log("res02", res);
		console.log("viewData", viewData);
		resdata = res;

		// 서버에서 가져온 예약 상태 데이터를 기반으로 일정의 배경색과 테두리색 설정
		let newViewData = viewData;
		let changeData = [];
        $.each(viewData, function(j, event) {
			$.each(resdata, function(i, v) {
// 				console.log(event, v)
				//console.log(event.start.substring(0,10),v.rsv_start_date.substring(0,10), event.start.substring(0,10) === v.rsv_start_date.substring(0,10))
				//console.log(v.campsite_no , event.title)
                if (v.campsite_no === event.title && event.start.substring(0,10) === v.rsv_start_date.substring(0,10) ) {
                	changeData.push(j);
//                 	newViewData[j].backgroundColor = "red";
//                 	newViewData[j].borderColor = "red";
// 					console.log(event, v);
                     
//                      event.end = v.rsv_end_date;
                 } else {
//                 	 newViewData[j].backgroundColor = "green";
//                 	 newViewData[j].borderColor = "green";
                 }
            });
        });
        
		$.each(changeData, function(i, index){
			
			viewData[index].backgroundColor = "red";
			viewData[index].borderColor = "red";
		});
		
        console.log("changeData", changeData)
		console.log("newViewData", viewData)
		viewCalendar(viewData);
		
        // FullCalendar를 업데이트하여 수정된 일정을 화면에 표시
//         calendar.removeAllEvents(); // 기존 일정 삭제
//         calendar.addEventSource(viewData); // 수정된 일정 추가
		
	},
	error : function(xhr){
		alert("status"+xhr.status);
	},
	dataType : 'json'
}) 

})

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

.fc-header-toolbar>div:nth-child(2) {
	display: flex;
}

.fc-header-toolbar>div:last-child {
	display: none;
}

.fc .fc-daygrid-day-top {
	margin-left: 5px;
	margin-top: 5px;
	flex-direction: row;
}

button {
	background: #f1f0cb !important;
	border: none !important;
}

button span {
	color: #4d2222;
}

#subject {
	text-align: center;
	margin: 40px;
	font-size: 30px;
}

nav {
	text-align: center;
	margin: 30px;
	display: flex;
	justify-content: center;
}

#resbutton {
	text-align: center;
	/* border : 1px dotted green; */
	padding: 40px;
}

#resbutton a {
	margin: 10px;
	padding: 20px;
	border: 4px solid #f1f0cb;
	background: white;
	border-radius: 25px;
	font-size: 20px;
	/* color: black; */
}

#resbutton a:link {
	text-decoration: none;
}

#resbutton a:hover {
	background: #f1f0cb;
	border-color: #f1f0cb;
}

#resbutton a:visited {
	text-decoration: none;
}

#resbutton a:active {
	/* color : none; */
	border-color: #f1f0cb;
}

#resbutton a:focus {
	outline: none;
}
</style>
</head>
<body>
	<div id="btns">
		<nav>
			<div id="resbutton">
				<a class="resbtn" id="resG" txt="G">글램핑 예약하기</a> <a class="resbtn"
					id="resA" txt="A">오토캠핑 예약하기</a> <a class="resbtn" id="resC" txt="C">카라반
					예약하기</a>
			</div>
		</nav>
	</div>
	<div id='calendar'></div>
</body>
</html>