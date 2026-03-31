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
                	// 1. 기존 방식대로 인스턴스를 가져옵니다.
                    PageObject pageObject = PageObject.getInstance(request);
                    
                    // 2. [매우 중요] JSP에서 보낸 검색 데이터를 직접 꺼냅니다.
                    String key = request.getParameter("key");
                    String word = request.getParameter("word");
                    
                    // 3. [디버깅용 콘솔 출력] - 이클립스 콘솔창에 이게 찍히는지 꼭 보세요!
                    System.out.println("컨트롤러 도착 -> key: " + key + ", word: " + word);
                    
                    // 4. PageObject 바구니에 직접 담아줍니다.
                    // (PageObject 클래스에 key, word 변수와 Getter/Setter가 있어야 에러가 안 납니다!)
                    pageObject.setKey(key);
                    pageObject.setWord(word);
                    
                    // 5. 서비스 실행
                    result = Execute.execute(Init.getService(uri), pageObject);
                    
                    request.setAttribute("list", result);
                    request.setAttribute("pageObject", pageObject);
                    return "agency/list";
                case "/agency/view.do":
                    // JSP에서 넘어오는 파라미터 이름은 보통 db 컬럼명과 맞추는 게 편합니다 (agency_id)
                    int id = Integer.parseInt(request.getParameter("agencyId")); 
                    result = Execute.execute(Init.getService(uri), id);
                    request.setAttribute("vo", result);
                    return "agency/view";

                case "/agency/write.do":
                    AgencyVO wvo = new AgencyVO();
                    wvo.setAgencyName(request.getParameter("agencyName"));
                    wvo.setAgencyType(request.getParameter("agencyType"));
                    wvo.setPhone(request.getParameter("phone"));
                    wvo.setAddress(request.getParameter("address"));
                    wvo.setLatitude(Double.parseDouble(request.getParameter("latitude")));
                    wvo.setLongitude(Double.parseDouble(request.getParameter("longitude")));
                    wvo.setOperatingHours(request.getParameter("operatingHours"));
                    
                    Execute.execute(Init.getService(uri), wvo);
                    return "redirect:list.do";
                    
                 // 1. 수정 폼
                case "/agency/updateForm.do":
                    // URL에 붙어온 agencyId를 가져옵니다.
                    int updateId = Integer.parseInt(request.getParameter("agencyId"));
                    
                    request.setAttribute("vo", Execute.execute(Init.getService("/agency/view.do"), updateId));
                    
                    // 아까 만든 updateForm.jsp로 이동합니다.
                    return "agency/updateForm";

                case "/agency/update.do":
                    AgencyVO uvo = new AgencyVO();
                    uvo.setAgencyId(Integer.parseInt(request.getParameter("agencyId")));
                    uvo.setAgencyName(request.getParameter("agencyName"));
                    uvo.setAgencyType(request.getParameter("agencyType"));
                    uvo.setPhone(request.getParameter("phone"));
                    uvo.setAddress(request.getParameter("address"));
                    uvo.setLatitude(Double.parseDouble(request.getParameter("latitude")));
                    uvo.setLongitude(Double.parseDouble(request.getParameter("longitude")));
                    uvo.setOperatingHours(request.getParameter("operatingHours"));
                    
                    Execute.execute(Init.getService(uri), uvo);
                    return "redirect:view.do?agencyId=" + uvo.getAgencyId();

                // 삭제 등 나머지 케이스 동일...
                default: return "error/404";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error/500";
        }
    }
}