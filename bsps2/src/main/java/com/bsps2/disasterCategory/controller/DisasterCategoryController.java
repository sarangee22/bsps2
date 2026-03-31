package com.bsps2.disasterCategory.controller;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;

public class DisasterCategoryController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
		// 잘못된 URI 처리 / 오류를 위한 URL 저장
		request.setAttribute("url", request.getRequestURL());
        try {
            String uri = request.getServletPath();

            switch (uri) {
			case "/disasterCategory/list.do":
				// 페이지 처리를 위한 객체
				// getInstance() - 객체를 생성해서 넘겨주세요.
				// - 1. PageObject를 생성한다. 2. request에서 page / 검색 정보를 받아서 세팅한다.
				PageObject pageObject = PageObject.getInstance(request);
				
				// 생성된 Service를 가져와서 실행 -> Execute가 실행하면 로그를 남긴다.
				// DB에서 데이터 수집을 해온다.
				// 사용자에게 제공한다.
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				// 처리된 후의 pageObject 데이터 확인
				System.out.println("BoardController.execuete().pageObject - " + pageObject);
				request.setAttribute("pageObject", pageObject);
				// jsp의 위치 정보 "/WEB-INF/views/" + "board/list" + ".jsp"
				return "/disasterCategory/list";

                default:
                    return "error/noPage";
            }// switch ~ case 의 끝
        } // try 정상처리 의 끝
        catch (Exception e) {
			// 개발자를 위한 코드
			e.printStackTrace();
			// 잘못된 예외 처리 - 사용자에게 보여주기
			request.setAttribute("moduleName", "일반 게시판");
			request.setAttribute("e", e);
			// /WEB-INF/views/ + error/err_500 + .jsp
			return "error/err_500";
        }
    }
}