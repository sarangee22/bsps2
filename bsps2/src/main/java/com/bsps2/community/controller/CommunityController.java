package com.bsps2.community.controller;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class CommunityController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {
		request.setAttribute("url", request.getRequestURL()); // 오류 페이지의 URL
		
		HttpSession session = request.getSession();
		
		String uri = request.getServletPath();
		System.out.println("CommunityController.execute(). uri = " + uri);
		
		try {
			switch (uri) {
			
			//1.리스트
			case "/community/list.do":
				PageObject pageObject = PageObject.getInstance(request);
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				request.setAttribute("pageObject", pageObject);
				return "community/list";
				
			//2.글보기
			case "/community/view.do":
				Long no = Long.parseLong(request.getParameter("no"));
				Long inc = Long.parseLong(request.getParameter("inc"));
				
				request.setAttribute("vo", Execute.execute(Init.getService(uri), new Long[] {no,inc}));				
				return "community/view";
				
			//3.글등록
			
				
				
			default:
				return "error/noPage";
			}
		}catch (Exception e) {
			e.printStackTrace();
			return "error/err_500";
		
			
		}
		
	}

}
