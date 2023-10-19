<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.vo.RsvVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 서블릿에서 저장한 데이터 꺼내기
    List<RsvVO> calendarList = (List<RsvVO>) request.getAttribute("calendarList");
/*     if (calendarList != null) {
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("[");

        for (int i = 0; i < calendarList.size(); i++) {
            RsvVO vo = calendarList.get(i);
            jsonBuilder.append("{");
            jsonBuilder.append("\"title\": \"").append(vo.getRsv_no()).append("\",");
            jsonBuilder.append("\"start\": \"").append(vo.getRsv_date()).append("\",");
            jsonBuilder.append("\"end\": \"").append(vo.getRsv_end_date()).append("\",");
            jsonBuilder.append("\"color\": '#' + Math.round(Math.random() * 0xffffff).toString(16)");

            if (i < calendarList.size() - 1) {
                jsonBuilder.append("},");
            } else {
                jsonBuilder.append("}");
            }
        }

        jsonBuilder.append("]");
        jsonCalendarList = jsonBuilder.toString();
    } */
%>

 [  
        <% if (calendarList != null) {
        	int i=0;%>
            <% for (RsvVO vo : calendarList) {
            	if(i > 0) out.print(",");

            %>
                {
                    "title": "<%= vo.getRsv_no() %>",
                    "start": "<%= vo.getRsv_start_date() %>",
                    "end": "<%= vo.getRsv_end_date() %>"
                    <%-- "color": "# + Math.round(Math.random() * 0xffffff).toString(16)" --%>
                    
                }
            <% i++;
            } %>
        <% } %>
  ]
