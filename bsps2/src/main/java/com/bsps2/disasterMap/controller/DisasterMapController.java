package com.bsps2.disasterMap.controller;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;

import com.bsps2.disasterMap.ov.DisasterMapVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class DisasterMapController implements Controller {

	@Override
	public String execute(HttpServletRequest request) {

		request.setAttribute("url", request.getRequestURL());
		HttpSession session = request.getSession();

		try {

			String uri = request.getServletPath();
			System.out.println("DisasterMapController.execute().uri = " + uri);

			switch (uri) {

			// 리스트
			case "/disasterMap/list.do":

				PageObject pageObject = PageObject.getInstance(request);

				request.setAttribute("list",
						Execute.execute(Init.getService(uri), pageObject));

				request.setAttribute("pageObject", pageObject);

				return "disasterMap/list";

			// 상세보기
			case "/disasterMap/view.do":

				Long disasterId = Long.parseLong(request.getParameter("disasterId"));

				request.setAttribute("vo",
						Execute.execute(Init.getService(uri), disasterId));

				return "disasterMap/view";

			// 글쓰기 폼
			case "/disasterMap/writeForm.do":

				return "disasterMap/writeForm";

			// 글쓰기
			case "/disasterMap/write.do":

				DisasterMapVO vo = new DisasterMapVO();

				vo.setDisasterName(request.getParameter("disasterName"));
				vo.setDisasterType(request.getParameter("disasterType"));
				vo.setRegion(request.getParameter("region"));
				vo.setAddress(request.getParameter("address"));
				vo.setLatitude(Double.parseDouble(request.getParameter("latitude")));
				vo.setLongitude(Double.parseDouble(request.getParameter("longitude")));
				vo.setContent(request.getParameter("content"));

				Execute.execute(Init.getService(uri), vo);

				session.setAttribute("msg", "재난 정보가 등록되었습니다.");

				return "redirect:list.do";

			// 수정
			case "/disasterMap/update.do":

				vo = new DisasterMapVO();

				vo.setDisasterId(Integer.parseInt(request.getParameter("disasterId")));
				vo.setDisasterName(request.getParameter("disasterName"));
				vo.setDisasterType(request.getParameter("disasterType"));
				vo.setRegion(request.getParameter("region"));
				vo.setAddress(request.getParameter("address"));
				vo.setLatitude(Double.parseDouble(request.getParameter("latitude")));
				vo.setLongitude(Double.parseDouble(request.getParameter("longitude")));
				vo.setContent(request.getParameter("content"));

				Integer result = (Integer) Execute.execute(Init.getService(uri), vo);

				if(result == 1)
					session.setAttribute("msg", "재난 정보가 수정되었습니다.");
				else
					session.setAttribute("msg", "수정 실패");

				return "redirect:view.do?disasterId=" + vo.getDisasterId();

			// 삭제
			case "/disasterMap/delete.do":

				Long disasterId2 = Long.parseLong(request.getParameter("disasterId"));

				result = (Integer) Execute.execute(Init.getService(uri), disasterId2);

				if(result == 1)
					session.setAttribute("msg", "삭제되었습니다.");

				return "redirect:list.do";

			default:

				System.out.println("DisasterMapController - 없는 주소: " + uri);

				return "error/noPage";
			}

		} catch (Exception e) {

			e.printStackTrace();
			return "error/err_500";
		}
	}
}