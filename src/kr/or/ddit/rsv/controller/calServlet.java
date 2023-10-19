package kr.or.ddit.rsv.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.rsv.service.IRsvService;
import kr.or.ddit.rsv.service.RsvServiceImpl;
import kr.or.ddit.vo.RsvVO;

@WebServlet("/cal.do")
public class calServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		// 요청받을 변수 선언
		//String command = request.getParameter("command");
		
		/*
		 * if (command != null && command.equals("calendar")) {
		 * response.sendRedirect("calendarTest.jsp"); } else { String viewpage =
		 * "calendarTest.jsp"; List<RsvVO> calendar = null;
		 * 
		 * try { calendar = (List<RsvVO>) RsvServiceImpl.getInstance();
		 * 
		 * request.setAttribute("calendarList", calendar); } catch (Exception e) {
		 * e.printStackTrace(); }
		 * 
		 * RequestDispatcher dispatcher =
		 * request.getRequestDispatcher("/view/result.jsp"); dispatcher.forward(request,
		 * response); }
		 */
		
		IRsvService  calendar = RsvServiceImpl.getInstance();
		
		 List<RsvVO>  list =calendar.selectRsv();
		 request.setAttribute("calendarList", list);
		 
		
		 request.getRequestDispatcher("/view/rsvList.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	
}
