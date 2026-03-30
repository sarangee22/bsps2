package com.bsps2.community.controller;

import com.bsps2.community.vo.CommunityVO;
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
				
			//3-1.글등록 폼
			case "/community/writeForm.do":
				return "community/writeForm";
			
			//3-2 글등록 처리
			case "/community/write.do":
				CommunityVO vo = new CommunityVO();
				vo.setTitle(request.getParameter("title"));
				vo.setContent(request.getParameter("content"));
				vo.setWriter(request.getParameter("writer"));
				vo.setPw(request.getParameter("pw"));
				vo.setFileName(request.getParameter("fileName"));
				
				Execute.execute(Init.getService(uri), vo);
				session.setAttribute("msg", "새로운 제보 글이 등록되었습니다.");
				return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
				
				
			default:
				return "error/noPage";
			}
		}catch (Exception e) {
			e.printStackTrace();
			return "error/err_500";
		
			
		}
		
	}

}
