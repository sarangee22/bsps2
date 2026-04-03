package com.bsps2.disasterSafe.controller;

import com.bsps2.disasterSafe.vo.AgencyVO;
import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.member.vo.LoginVO;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AgencyController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        // 알림창 메시지 및 권한 체크를 위해 세션을 가져옵니다.
        HttpSession session = request.getSession();

        try {
            String uri = request.getServletPath();
            Object result = null;

            // 세션에서 로그인 정보를 미리 꺼내둡니다. (중복 선언 방지)
            LoginVO login = (LoginVO) session.getAttribute("login");

            switch (uri) {
                // 1. 기관 리스트
                case "/agency/list.do":
                    PageObject pageObject = PageObject.getInstance(request);
                    pageObject.setKey(request.getParameter("key"));
                    pageObject.setWord(request.getParameter("word"));

                    result = Execute.execute(Init.getService(uri), pageObject);

                    request.setAttribute("list", result);
                    request.setAttribute("pageObject", pageObject);
                    return "agency/list";

                // 2. 상세보기
                case "/agency/view.do":
                    int id = Integer.parseInt(request.getParameter("agencyId"));
                    result = Execute.execute(Init.getService(uri), id);
                    request.setAttribute("vo", result);
                    return "agency/view";

                // 3. 등록 폼 (관리자만 접근 가능)
                case "/agency/writeForm.do":
                    if (login == null || !login.getGradeName().equals("관리자")) {
                        session.setAttribute("msg", "관리자 권한이 필요한 메뉴입니다.");
                        return "redirect:list.do";
                    }
                    return "agency/writeForm";

                // 4. 등록 처리 (관리자만 실행 가능)
                case "/agency/write.do":
                    if (login == null || !login.getGradeName().equals("관리자")) {
                        session.setAttribute("msg", "등록 권한이 없습니다.");
                        return "redirect:list.do";
                    }
                    AgencyVO wvo = new AgencyVO();
                    wvo.setAgencyName(request.getParameter("agencyName"));
                    wvo.setAgencyType(request.getParameter("agencyType"));
                    wvo.setPhone(request.getParameter("phone"));
                    wvo.setAddress(request.getParameter("address"));

                    String lat = request.getParameter("latitude");
                    wvo.setLatitude((lat != null && !lat.isEmpty()) ? Double.parseDouble(lat) : 0.0);
                    String lng = request.getParameter("longitude");
                    wvo.setLongitude((lng != null && !lng.isEmpty()) ? Double.parseDouble(lng) : 0.0);
                    wvo.setOperatingHours(request.getParameter("operatingHours"));

                    Execute.execute(Init.getService(uri), wvo);
                    session.setAttribute("msg", "새로운 재난 관리 기관이 등록되었습니다.");
                    return "redirect:list.do";

                // 5. 수정 폼 (관리자만 접근 가능)
                case "/agency/updateForm.do":
                    if (login == null || !login.getGradeName().equals("관리자")) {
                        session.setAttribute("msg", "수정 권한이 없습니다.");
                        return "redirect:view.do?agencyId=" + request.getParameter("agencyId");
                    }
                    int updateId = Integer.parseInt(request.getParameter("agencyId"));
                    request.setAttribute("vo", Execute.execute(Init.getService("/agency/view.do"), updateId));
                    return "agency/updateForm";

                // 6. 수정 처리 (관리자만 실행 가능)
                case "/agency/update.do":
                    if (login == null || !login.getGradeName().equals("관리자")) {
                        session.setAttribute("msg", "수정 권한이 없습니다.");
                        return "redirect:view.do?agencyId=" + request.getParameter("agencyId");
                    }

                    AgencyVO uvo = new AgencyVO();
                    uvo.setAgencyId(Integer.parseInt(request.getParameter("agencyId")));
                    uvo.setAgencyName(request.getParameter("agencyName"));
                    uvo.setAgencyType(request.getParameter("agencyType"));
                    uvo.setPhone(request.getParameter("phone"));
                    uvo.setAddress(request.getParameter("address"));

                    String uLat = request.getParameter("latitude");
                    uvo.setLatitude((uLat != null && !uLat.isEmpty()) ? Double.parseDouble(uLat) : 0.0);
                    String uLng = request.getParameter("longitude");
                    uvo.setLongitude((uLng != null && !uLng.isEmpty()) ? Double.parseDouble(uLng) : 0.0);
                    uvo.setOperatingHours(request.getParameter("operatingHours"));

                    result = Execute.execute(Init.getService(uri), uvo);

                    if (result != null && (Integer) result == 1) {
                        session.setAttribute("msg", "기관 정보가 수정되었습니다.");
                    } else {
                        session.setAttribute("msg", "수정에 실패했습니다.");
                    }
                    return "redirect:view.do?agencyId=" + uvo.getAgencyId();

                // 7. 삭제 처리 (관리자만 실행 가능)
                case "/agency/delete.do":
                    if (login == null || !login.getGradeName().equals("관리자")) {
                        session.setAttribute("msg", "삭제 권한이 없습니다.");
                        return "redirect:view.do?agencyId=" + request.getParameter("agencyId");
                    }

                    int deleteId = Integer.parseInt(request.getParameter("agencyId"));
                    Execute.execute(Init.getService(uri), deleteId);

                    session.setAttribute("msg", "기관 정보가 삭제되었습니다.");
                    // 삭제 후에는 데이터가 없으므로 리스트로 이동
                    return "redirect:list.do";

                default:
                    return "error/404";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("exception", e);
            return "error/500";
        }
    }
}