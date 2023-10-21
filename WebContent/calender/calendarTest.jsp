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
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet'/>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
  
<script>

   getData = ajaxProc();

    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
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
    
    
    function ajaxProc(){
    	resdata = null;
    	$.ajax({
    		url : '<%= request.getContextPath()%>/cal.do',
    		type : 'get',
    		async : false,
 //   		data : {'command' : 'calendar'},
    		success : function(res){
    			resdata = res;
    		},
    		error : function(xhr){
    			alert("상태 : " + xhr.status)
    		},
    		dataType  : 'json'
 		
    	})
    	return resdata;
    }
</script>

</head>
<body>
<div id='calendar'></div>
</body>
</html>