package com.bsps2.disasterSafe.controller;

import com.bsps2.disasterSafe.vo.AgencyVO;
import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession; // 세션 사용을 위해 추가

public class AgencyController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        // 알림창 메시지를 담기 위해 세션을 가져옵니다.
        HttpSession session = request.getSession();

        try {
            String uri = request.getServletPath(); // getRequestURI보다 더 정확한 경로 추출
            Object result = null;

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

                // 3. 등록 폼
                case "/agency/writeForm.do":
                    return "agency/writeForm";

                // 4. 등록 처리
                case "/agency/write.do":
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
                    // ✅ 등록 성공 메시지 세팅
                    session.setAttribute("msg", "새로운 재난 관리 기관이 등록되었습니다.");
                    return "redirect:list.do";

                // 5. 수정 폼
                case "/agency/updateForm.do":
                    int updateId = Integer.parseInt(request.getParameter("agencyId"));
                    request.setAttribute("vo", Execute.execute(Init.getService("/agency/view.do"), updateId));
                    return "agency/updateForm";

                // 6. 수정 처리
                case "/agency/update.do":
                    AgencyVO uvo = new AgencyVO();
                    uvo.setAgencyId(Integer.parseInt(request.getParameter("agencyId")));
                    uvo.setAgencyName(request.getParameter("agencyName"));
                    uvo.setAgencyType(request.getParameter("agencyType"));
                    uvo.setPhone(request.getParameter("phone"));
                    uvo.setAddress(request.getParameter("address")); // 주소 누락 방지
                    
                    String uLat = request.getParameter("latitude");
                    uvo.setLatitude((uLat != null && !uLat.isEmpty()) ? Double.parseDouble(uLat) : 0.0);
                    String uLng = request.getParameter("longitude");
                    uvo.setLongitude((uLng != null && !uLng.isEmpty()) ? Double.parseDouble(uLng) : 0.0);
                    uvo.setOperatingHours(request.getParameter("operatingHours")); // 영업시간 누락 방지

                    result = Execute.execute(Init.getService(uri), uvo);
                    
                    // ✅ 수정 성공 여부에 따른 메시지 세팅
                    if(result != null && (Integer)result == 1) {
                        session.setAttribute("msg", "기관 정보가 성공적으로 수정되었습니다.");
                    } else {
                        session.setAttribute("msg", "수정에 실패했습니다.");
                    }
                    
                    return "redirect:view.do?agencyId=" + uvo.getAgencyId();

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