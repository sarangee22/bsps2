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
				
				
				
				
				
			
			default:
			
				return "error/noPage";
			}
		}catch (Exception e) {
			e.printStackTrace();
			return "error/err_500";
    }
  }
}