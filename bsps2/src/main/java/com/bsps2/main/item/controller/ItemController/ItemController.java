package com.bsps2.main.item.controller.ItemController; 

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.item.vo.ItemVO.ItemVO;
// 2. 이 부분이 핵심입니다. .ItemVO.ItemVO가 아니라 클래스 이름 하나만 적어야 합니다.
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class ItemController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {
		request.setAttribute("url", request.getRequestURL());
		HttpSession session = request.getSession();
		
		try {
			// [수정] getRequestURI() 대신 getServletPath()를 사용해야 /item/list.do만 깔끔하게 가져옵니다.
			String uri = request.getServletPath();
			System.out.println("ItemController.execute().uri = " + uri);
			
			switch (uri) {
			case "/item/list.do":
				PageObject pageObject = PageObject.getInstance(request);
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				request.setAttribute("pageObject", pageObject);
				return "item/list";

			case "/item/writeForm.do":
				return "item/writeForm";
				
			case "/item/write.do":
				ItemVO vo = new ItemVO();
				vo.setId("test_user"); 
				vo.setName(request.getParameter("name"));
				vo.setCategory(request.getParameter("category"));
				vo.setMemo(request.getParameter("memo"));
				Execute.execute(Init.getService(uri), vo);
				session.setAttribute("msg", "비상물품이 성공적으로 등록되었습니다.");
				return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
				
			case "/item/view.do":
				Long no = Long.parseLong(request.getParameter("no"));
				request.setAttribute("vo", Execute.execute(Init.getService(uri), no));
				return "item/view";
				
			case "/item/updateForm.do":
				no = Long.parseLong(request.getParameter("no"));
				request.setAttribute("vo", Execute.execute(Init.getService("/item/view.do"), no));
				return "item/updateForm";
				
			case "/item/update.do":
				vo = new ItemVO();
				vo.setNo(Long.parseLong(request.getParameter("no")));
				vo.setName(request.getParameter("name"));
				vo.setCategory(request.getParameter("category"));
				vo.setIsReady(request.getParameter("isReady"));
				vo.setMemo(request.getParameter("memo"));
				Integer result = (Integer) Execute.execute(Init.getService(uri), vo);
				
				if(result == 1) session.setAttribute("msg", "물품 정보가 수정되었습니다.");
				else session.setAttribute("msg", "수정에 실패했습니다.");
				
				return "redirect:view.do?no=" + vo.getNo() + "&page=" + request.getParameter("page") + "&perPageNum=" + request.getParameter("perPageNum");
				
			case "/item/delete.do":
				no = Long.parseLong(request.getParameter("no"));
				result = (Integer) Execute.execute(Init.getService(uri), no);
				if(result == 1) session.setAttribute("msg", "물품이 삭제되었습니다.");
				return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
				
			default:
				// 만약 주소가 안 맞으면 이쪽으로 빠져서 "JSP가 존재하지 않습니다"가 뜨는 겁니다.
				System.out.println("ItemController.execute() - 요청한 페이지가 switch문에 없습니다: " + uri);
				return "error/noPage";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error/err_500";
		}
	}
}