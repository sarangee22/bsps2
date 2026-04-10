package com.bsps2.scrap.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.member.vo.LoginVO;
import com.bsps2.scrap.vo.ScrapVO;
import com.bsps2.util.page.PageObject;

public class ScrapController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        String uri = request.getServletPath();
        HttpSession session = request.getSession();
        LoginVO login = (LoginVO) session.getAttribute("login");

        try {
            // 모든 스크랩 요청 로그인이 필수
            if (login == null) {
                session.setAttribute("msg", "로그인이 필요한 서비스입니다.");
                return "redirect:/member/loginForm.do"; // loginForm으로 경로 확인 필요
            }

            String id = login.getId();

            switch (uri) {
                case "/scrap/list.do":
                    // 1. 페이지 및 검색 정보 생성
                    PageObject pageObject = PageObject.getInstance(request);
                    
                    // 2. [수정] 다른 케이스들처럼 Init.getService(uri)를 사용해서 서비스를 가져옴
                    // 배열로 묶어서 전달하여 Service와 DAO의 변경사항을 수용함
                    request.setAttribute("list", Execute.execute(Init.getService(uri), new Object[] { id, pageObject }));
                    
                    // 3. JSP 페이징 처리용
                    request.setAttribute("pageObject", pageObject);
                    
                    return "scrap/list";

                case "/scrap/write.do":
                    long no = Long.parseLong(request.getParameter("no"));
                    
                    ScrapVO scrapVO = new ScrapVO();
                    scrapVO.setId(id);
                    scrapVO.setNo(no);
                    
                    Execute.execute(Init.getService(uri), scrapVO);
                    session.setAttribute("msg", "성공적으로 스크랩되었습니다.");
                    return "redirect:list.do";

                case "/scrap/delete.do":
                    long scrapNo = Long.parseLong(request.getParameter("scrapNo"));
                    Execute.execute(Init.getService(uri), scrapNo);
                    session.setAttribute("msg", "스크랩이 삭제되었습니다.");
                    return "redirect:list.do";

                default:
                    return "error/noPage";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("e", e);
            return "error/err_500";
        }
    }
}