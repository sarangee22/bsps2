package com.bsps2.disasterSafe.controller;

import com.bsps2.disasterSafe.vo.AgencyVO;
import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;

public class AgencyController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        try {
            String uri = request.getRequestURI();
            Object result = null;

            switch (uri) {
                case "/agency/list.do":
                    PageObject pageObject = PageObject.getInstance(request);
                    pageObject.setKey(request.getParameter("key"));
                    pageObject.setWord(request.getParameter("word"));
                    
                    result = Execute.execute(Init.getService(uri), pageObject);
                    
                    request.setAttribute("list", result);
                    request.setAttribute("pageObject", pageObject);
                    return "agency/list";

                case "/agency/view.do":
                    int id = Integer.parseInt(request.getParameter("agencyId")); 
                    result = Execute.execute(Init.getService(uri), id);
                    request.setAttribute("vo", result);
                    return "agency/view";

                case "/agency/writeForm.do":
                    return "agency/writeForm";

                case "/agency/write.do":
                    AgencyVO wvo = new AgencyVO();
                    wvo.setAgencyName(request.getParameter("agencyName"));
                    wvo.setAgencyType(request.getParameter("agencyType"));
                    wvo.setPhone(request.getParameter("phone"));
                    
                    // 만약 JSP에 주소/위도/경도 입력란이 없다면 null 에러 방지를 위해 체크
                    String addr = request.getParameter("address");
                    wvo.setAddress((addr != null) ? addr : "정보 없음");
                    
                    String lat = request.getParameter("latitude");
                    wvo.setLatitude((lat != null && !lat.isEmpty()) ? Double.parseDouble(lat) : 0.0);
                    
                    String lng = request.getParameter("longitude");
                    wvo.setLongitude((lng != null && !lng.isEmpty()) ? Double.parseDouble(lng) : 0.0);
                    
                    String hours = request.getParameter("operatingHours");
                    wvo.setOperatingHours((hours != null) ? hours : "24시간");

                    Execute.execute(Init.getService(uri), wvo);
                    return "redirect:list.do";

                case "/agency/updateForm.do":
                    int updateId = Integer.parseInt(request.getParameter("agencyId"));
                    request.setAttribute("vo", Execute.execute(Init.getService("/agency/view.do"), updateId));
                    return "agency/updateForm";

                case "/agency/update.do":
                    AgencyVO uvo = new AgencyVO();
                    uvo.setAgencyId(Integer.parseInt(request.getParameter("agencyId")));
                    uvo.setAgencyName(request.getParameter("agencyName"));
                    uvo.setAgencyType(request.getParameter("agencyType"));
                    uvo.setPhone(request.getParameter("phone"));
                    
                    // 수정 시에도 숫자 데이터 파싱 에러 주의
                    String uLat = request.getParameter("latitude");
                    uvo.setLatitude((uLat != null && !uLat.isEmpty()) ? Double.parseDouble(uLat) : 0.0);
                    String uLng = request.getParameter("longitude");
                    uvo.setLongitude((uLng != null && !uLng.isEmpty()) ? Double.parseDouble(uLng) : 0.0);

                    Execute.execute(Init.getService(uri), uvo);
                    return "redirect:view.do?agencyId=" + uvo.getAgencyId();

                default: 
                    return "error/404";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error/500";
        }
    }
}