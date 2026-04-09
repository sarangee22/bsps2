package com.bsps2.scrap.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.member.vo.LoginVO;
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
        
        

        try {
            switch (uri) {
            // 1. 스크랩 목록 보기
            case "/scrap/list.do":
                // 세션에서 로그인 정보 확인
            		session = request.getSession();
                LoginVO login = (LoginVO) session.getAttribute("login");
                
                // 2. 로그인 안 된 경우 처리
                if (login == null) {
                    // 메시지 전달을 위해 request에 저장 (msg 객체 활용 환경이라 가정)
                    request.setAttribute("msg", "로그인이 필요한 서비스입니다.");
                    // 로그인 페이지로 리다이렉트 시 메시지를 띄우기 위해 유틸리티 사용 가능
                    return "redirect:/member/login.do"; 
                }

                // 3. 로그인 된 경우에만 ID 추출 및 서비스 실행
                String id = login.getId();
                request.setAttribute("list", Execute.execute(Init.getService(uri), id));
                return "scrap/list";
                

                // 2. 스크랩 저장
                case "/scrap/scrap.do":
                		session = request.getSession();
                		LoginVO loginSave = (LoginVO) session.getAttribute("login");
                    
                    if (loginSave == null) {
                        request.setAttribute("msg", "로그인 후 이용 가능합니다.");
                        return "member/login";
                    }

                    String scrapId = loginSave.getId();
                    long no = Long.parseLong(request.getParameter("no"));
                    
                    ScrapVO vo = new ScrapVO();
                    vo.setId(loginSave.getId()); 
                    vo.setNo(no);
                    
                    Execute.execute(Init.getService(uri), vo);
                    
                    return "redirect:list.do";

                // 3. 스크랩 삭제
                case "/scrap/delete.do":
                    session = request.getSession();
                    LoginVO loginDel = (LoginVO) session.getAttribute("login");
                    
                    if (loginDel == null) {
                        request.setAttribute("msg", "권한이 없습니다.");
                        return "member/login";
                    }

                    long scrapNo = Long.parseLong(request.getParameter("scrapNo"));
                    Execute.execute(Init.getService(uri), scrapNo);
                    
                    return "redirect:list.do";
                    
                case "/scrap/write.do":
                    // 1. 데이터 수집 (글번호, 아이디)
                    String noStr = request.getParameter("no");
                    
                    // 💡 [수정] id를 파라미터가 아닌 세션에서 가져와야 안전합니다.
                    session = request.getSession();
                    login = (LoginVO) session.getAttribute("login");
                    
                    // 로그인 체크 (방어 로직)
                    if (login == null) {
                        request.setAttribute("msg", "로그인이 필요한 서비스입니다.");
                        return "member/login";
                    }
                    
                    scrapId = login.getId();
                    
                    // 2. 서비스 실행 (DB 저장)
                    // 💡 주석을 풀고, VO 객체에 담아서 보냅니다. (에러 났던 id 초기화 해결)
                    vo = new ScrapVO();
                    vo.setNo(Long.parseLong(noStr));
                    vo.setId(scrapId);
                    
                    Execute.execute(Init.getService(uri), vo);
                    
                    // 3. 처리 후 리다이렉트
                    // 💡 session에 담으면 리다이렉트 후에도 메시지가 유지됩니다.
                    session.setAttribute("msg", "성공적으로 스크랩되었습니다.");
                    
                    // 원래 요청하신 대로 스크랩 리스트로 바로 보냅니다.
                    return "redirect:list.do";
                    
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