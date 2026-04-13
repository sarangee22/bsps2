package com.bsps2.disasterList.controller;

import java.util.Map;
import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;

public class DisasterListController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        request.setAttribute("url", request.getRequestURL());
        try {
            String uri = request.getServletPath();

            switch (uri) {
                case "/disasterList/list.do":
                    // 1. 카테고리 번호 수집 (기본값 1)
                    String catIDStr = request.getParameter("catID");
                    int catID = (catIDStr != null && !catIDStr.equals("")) ? Integer.parseInt(catIDStr) : 1;
                    
                    // 2. 헤드 타이틀 설정 (확장)
                    String headTitle = switch(catID) {
                        case 1 -> "피해/폭발(산불 포함)";
                        case 2 -> "지진/해일";
                        case 3 -> "태풍/호우(폭풍, 홍수 포함)";
                        case 4 -> "폭염/한파(기온 관련)";
                        case 5 -> "산사태/붕괴";
                        case 6 -> "교통/산업사고";
                        case 7 -> "감염병/환경";
                        case 8 -> "응급처치/대피소";
                        case 9 -> "기타/미분류";
                        case 10 -> "행안부 재난문자";
                        default -> "재난 안전 정보";
                    };
                    request.setAttribute("headTitle", headTitle);

                    // 3. 페이지 처리
                    PageObject pageObject = PageObject.getInstance(request);
                    
                    // 4. 서비스 실행 (배열로 데이터 전달)
                    Object[] sendData = new Object[] { catID, pageObject };
                    request.setAttribute("list", Execute.execute(Init.getService(uri), sendData));
                    request.setAttribute("pageObject", pageObject);
                    
                    return "disasterList/list";

                case "/disasterList/view.do":
                    long no = Long.parseLong(request.getParameter("no"));
                    // inc가 없을 경우를 대비한 기본값 처리
                    String incStr = request.getParameter("inc");
                    long inc = (incStr != null) ? Long.parseLong(incStr) : 0;

                    // DB 데이터 가져오기
                    DisasterVO vo = (DisasterVO) Execute.execute(Init.getService(uri), new Object[]{no, inc}); 
                    
                    request.setAttribute("vo", vo);
                    
                    return "disasterList/view";

                default:
                    return "error/noPage";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("moduleName", "재난안전 목록");
            request.setAttribute("e", e);
            return "error/err_500";
        }
    }
}