package com.bsps2.quiz.controller;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.quiz.vo.QuizVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class QuizController implements Controller {
	@Override
	public String execute(HttpServletRequest request) {
		request.setAttribute("url", request.getRequestURL()); // 오류 페이지의 URL
		
		HttpSession session = request.getSession();
		
		String uri = request.getServletPath();
		System.out.println("QuizController.execute(). uri = " + uri);
		
		try {
			QuizVO vo;
			Long no;
			Integer result;
			switch (uri) {
			
			case "/quiz/list.do":
                request.setAttribute("list", Execute.execute(Init.getService(uri), null));
                return "quiz/list";
                
			case "/quiz/view.do":
			    String strNo = request.getParameter("no");
			    String strInc = request.getParameter("inc");

			    // 파라미터가 null일 경우를 대비한 안전한 변환
			    no = Long.parseLong(strNo);
			    // inc가 없으면(null) 기본값 0으로 처리하여 NumberFormatException 방지
			    long inc = (strInc == null || strInc.equals("")) ? 0L : Long.parseLong(strInc); 

			    // 서비스에 배열로 전달 (기존 QuizViewService 구조 유지)
			    request.setAttribute("vo", Execute.execute(Init.getService(uri), new Long[] {no, inc}));
			    return "quiz/view";
				
				
				
				
				
			
			default:
			
				return "error/noPage";
			}
		}catch (Exception e) {
			e.printStackTrace();
			return "error/err_500";
    }
  }
}