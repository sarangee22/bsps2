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

		HttpSession session = request.getSession();

		try {
			// requestURI 대신 getServletPath()를 사용해 정확한 경로를 추출합니다.
			String uri = request.getServletPath();
			System.out.println("DisasterMapController.execute().uri = " + uri);

			Object result = null;

			switch (uri) {

			// 1. 재난 현황 리스트 (지도 포함 페이지)
			case "/disasterMap/list.do":
				PageObject pageObject = PageObject.getInstance(request);
				// 서비스로부터 결과 리스트를 가져와 "list"에 담습니다.
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				request.setAttribute("pageObject", pageObject);
				return "disasterMap/list";

			// 2. 재난 상세 정보 보기 (중요: 파라미터명이 list.jsp의 링크와 일치해야 함)
			case "/disasterMap/view.do":
				String strId = request.getParameter("disasterId");
				
				// 파라미터가 없으면 에러 페이지 대신 리스트로 돌려보냄
				if(strId == null || strId.trim().isEmpty()) {
					System.out.println("실패: disasterId가 전달되지 않았습니다.");
					return "redirect:list.do"; 
				}
				
				Long viewId = Long.parseLong(strId);
				// 결과 객체를 "vo"라는 이름으로 담습니다.
				request.setAttribute("vo", Execute.execute(Init.getService(uri), viewId));
				return "disasterMap/view";

			// 3. 재난 등록 폼
			case "/disasterMap/writeForm.do":
				return "disasterMap/writeForm";

			// 4. 재난 등록 처리
			case "/disasterMap/write.do":
				DisasterMapVO wvo = new DisasterMapVO();
				wvo.setDisasterName(request.getParameter("disasterName"));
				wvo.setDisasterType(request.getParameter("disasterType"));
				wvo.setRegion(request.getParameter("region"));
				wvo.setAddress(request.getParameter("address"));
				
				// 위도/경도 숫자 파싱 예외 처리
				String wLat = request.getParameter("latitude");
				String wLng = request.getParameter("longitude");
				wvo.setLatitude((wLat != null && !wLat.isEmpty()) ? Double.parseDouble(wLat) : 0.0);
				wvo.setLongitude((wLng != null && !wLng.isEmpty()) ? Double.parseDouble(wLng) : 0.0);
				
				wvo.setContent(request.getParameter("content"));

				Execute.execute(Init.getService(uri), wvo);
				session.setAttribute("msg", "새로운 재난 정보가 등록되었습니다.");
				return "redirect:list.do";

			// 5. 재난 수정 폼 (기존 데이터를 불러와서 폼에 채워줌)
			case "/disasterMap/updateForm.do":
				Long updateFormId = Long.parseLong(request.getParameter("disasterId"));
				// 보기(view) 서비스를 재사용하여 vo를 가져옴
				request.setAttribute("vo", Execute.execute(Init.getService("/disasterMap/view.do"), updateFormId));
				return "disasterMap/updateForm";

			// 6. 재난 수정 처리
			case "/disasterMap/update.do":
				DisasterMapVO uvo = new DisasterMapVO();
				// VO의 타입에 따라 Integer/Long 파싱 주의
				uvo.setDisasterId(Integer.parseInt(request.getParameter("disasterId")));
				uvo.setDisasterName(request.getParameter("disasterName"));
				uvo.setDisasterType(request.getParameter("disasterType"));
				uvo.setRegion(request.getParameter("region"));
				uvo.setAddress(request.getParameter("address"));
				
				String uLat = request.getParameter("latitude");
				String uLng = request.getParameter("longitude");
				uvo.setLatitude((uLat != null && !uLat.isEmpty()) ? Double.parseDouble(uLat) : 0.0);
				uvo.setLongitude((uLng != null && !uLng.isEmpty()) ? Double.parseDouble(uLng) : 0.0);
				
				uvo.setContent(request.getParameter("content"));

				result = Execute.execute(Init.getService(uri), uvo);

				if(result != null && (Integer)result == 1) {
					session.setAttribute("msg", "정보가 성공적으로 수정되었습니다.");
				} else {
					session.setAttribute("msg", "수정에 실패했습니다.");
				}
				// 수정한 글로 다시 이동
				return "redirect:view.do?disasterId=" + uvo.getDisasterId();

			// 7. 재난 삭제 처리
			case "/disasterMap/delete.do":
				Long deleteId = Long.parseLong(request.getParameter("disasterId"));
				result = Execute.execute(Init.getService(uri), deleteId);

				if(result != null && (Integer)result == 1) {
					session.setAttribute("msg", "성공적으로 삭제되었습니다.");
				}
				return "redirect:list.do";

			default:
				System.out.println("DisasterMapController - 존재하지 않는 경로: " + uri);
				return "error/noPage";
			}

		} catch (Exception e) {
			e.printStackTrace();
			// 에러 발생 시 request에 예외 객체를 담아 500 에러 페이지로 보냄
			request.setAttribute("exception", e);
			return "error/err_500";
		}
	}
}