package com.bsps2.disasterList.controller;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;

public class DisasterListController implements Controller{

	@Override
	public String execute(HttpServletRequest request) {
		
		// 잘못된 URI 처리 / 오류를 위한 URL 저장
		request.setAttribute("url", request.getRequestURL());
		try {// 정상처리
			// 요청 uri에 따라서 처리된다.
			// list - /disaster/list.do
			// 1. 재난안전 정보 목록 메뉴 입력
			String uri = request.getServletPath();

			// 2. 재난안전 정보 목록 메뉴 처리
			switch (uri) {
			// 1. 재난/안전 정보 카테고리 
			case "/disasterList/list.do":
				// 1. 카테고리 번호 수집
				String catIDStr = request.getParameter("catID");
				// 만약 catID가 없다면 기본값으로 1(화재 등)을 세팅합니다.
				int catID = (catIDStr != null) ? Integer.parseInt(catIDStr) : 1;
				
				// 리스트의 페이지 제목
				String headTitle = "";
			    switch(catID) {
			        case 1: headTitle = "화재/폭발(산불 포함)"; break;
			        case 2: headTitle = "지진/해일"; break;
			        case 3: headTitle = "태풍/호우(폭풍, 홍수 포함)"; break;
			        case 4: headTitle = "폭염/한파(기온 관련)"; break;
			        case 5: headTitle = "산사태/붕괴"; break;
			        case 6: headTitle = "교통/산업사고"; break;
			        case 7: headTitle = "감염병/환경"; break;
			        case 8: headTitle = "응급처치/대피소"; break;
			        default: headTitle = "재난 정보";
			    }			    
			
			    // JSP에서 쓸 수 있게 저장
			    request.setAttribute("headTitle", headTitle);
			    
				// 2. 페이지 처리를 위한 객체 생성 및 설정
				// - request에서 page, perPageNum, key, word 정보를 자동으로 담습니다.
				PageObject pageObject = PageObject.getInstance(request);
				
				// 3. [핵심 수정] 서비스로 넘길 데이터를 배열로 묶기
				// DAO가 (catID, pageObject) 두 개를 요구하므로 배열에 담아 보냅니다.
				Object[] sendData = new Object[] { catID, pageObject };
				
				// 4. 서비스 실행 및 결과 저장
				// Execute.execute가 서비스의 service(sendData)를 호출하게 됩니다.
				request.setAttribute("list", Execute.execute(Init.getService(uri), sendData));
				
				// 5. 처리된 후의 pageObject(totalRow가 세팅된 상태)를 request에 담기
				System.out.println("DisasterListController.execute().pageObject - " + pageObject);
				request.setAttribute("pageObject", pageObject);
				
				
				
				// 6. JSP 위치 리턴
				return "disasterList/list";
				
			case "/disasterList/view.do":
				// 글번호를 받는다. 1증가 데이터를 받는다. - 2개의 데이터는 반드시 넘어와야만 한다.
				Long no = (Long) Long.parseLong(request.getParameter("no"));
				//조회수
				long inc = Long.parseLong(request.getParameter("inc"));

				//DB에서 데이터 가져오기
				// new Long[] {no, 1L} - new Long[] {번호[0], 증가[1]} - 생성하고 바로 초기값을 세팅한다.
				// EL 또는 JSTL을 사용하기 위해서 4개의 저장 - request에 담자.
				request.setAttribute("vo", Execute.execute(Init.getService(uri), new Long[] {no, inc}));
				
				// jsp의 위치 정보 "/WEB-INF/views/" + "board/view" + ".jsp"
				return "disasterList/view";


			default:
				// /WEB-INF/views/ + error/noPage + .jsp
				return "error/noPage";
			}
		} catch (Exception e) {
			// 개발자를 위한 코드
			e.printStackTrace();
			// 잘못된 예외 처리 - 사용자에게 보여주기
			request.setAttribute("moduleName", "일반 게시판");
			request.setAttribute("e", e);
			// /WEB-INF/views/ + error/err_500 + .jsp
			return "error/err_500";
		}// // catch 의 끝
	} // execute()의 끝

}// class의 끝
