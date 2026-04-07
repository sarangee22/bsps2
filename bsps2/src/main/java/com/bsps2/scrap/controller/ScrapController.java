package com.bsps2.scrap.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.scrap.vo.ScrapVO;

/**
 * 스크랩 컨트롤러 (Controller 인터페이스 구현)
 */
public class ScrapController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        // 리턴할 JSP 경로
        String jsp = null;
        // 요청한 URI 가져오기
        String uri = request.getRequestURI();
        HttpSession session = request.getSession();
        
        // [임시 처리] 회원 모듈 미완성으로 인한 고정 아이디 사용
        String id = "test"; 

        try {
            switch (uri) {
                // 1. 스크랩 목록 보기
                case "/scrap/list.do":
                    // Execute.execute를 통해 ScrapService 호출
                    request.setAttribute("list", Execute.execute(Init.getService(uri), id));
                    jsp = "scrap/list";
                    break;

                // 2. 스크랩 저장
                case "/scrap/scrap.do":
                    long no = Long.parseLong(request.getParameter("no"));
                    
                    ScrapVO vo = new ScrapVO();
                    vo.setId(id);
                    vo.setNo(no);
                    
                    Execute.execute(Init.getService(uri), vo);
                    
                    // 저장 후 리스트로 리다이렉트
                    jsp = "redirect:list.do"; 
                    break;

                // 3. 스크랩 삭제
                case "/scrap/delete.do":
                    long scrapNo = Long.parseLong(request.getParameter("scrapNo"));
                    Execute.execute(Init.getService(uri), scrapNo);
                    jsp = "redirect:list.do";
                    break;
                    
                case "/scrap/write.do":
                    // 1. 데이터 수집 (글번호, 아이디)
                    String noStr = request.getParameter("no");
                    id = request.getParameter("id");
                    
                    // 2. 서비스 실행 (DB 저장)
                    // Execute.execute(Init.getService(uri), new Object[]{noStr, id});
                    
                    // 3. 처리 후 리다이렉트 (상세보기로 돌아가거나 메시지 띄우기)
                    session.setAttribute("msg", "성공적으로 스크랩되었습니다.");
                    jsp = "redirect:/disasterList/view.do?no=" + noStr + "&inc=0"; 
                    break;

                default:
                    jsp = "error/404";
                    break;
                    
            }
        } catch (Exception e) {
            // 예외 발생 시 콘솔 출력 및 에러 페이지 설정
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            jsp = "error/500";
        }

        return jsp;
    }
}