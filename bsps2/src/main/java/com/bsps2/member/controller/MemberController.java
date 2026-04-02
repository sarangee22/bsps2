package com.bsps2.member.controller;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.member.vo.LoginVO;
import com.bsps2.member.vo.MemberVO; 

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class MemberController implements Controller {

    public String execute(HttpServletRequest request) {
    	     Object result = null; 
         Integer intResult = 0;
         
        try {
            String uri = request.getServletPath();
            HttpSession session = request.getSession();
            
            LoginVO loginVO = (LoginVO) session.getAttribute("login");
            
            String loginId = null;
            if (loginVO != null) 
            	loginId = loginVO.getId();

            switch (uri) {
                // 1. 회원 리스트 (관리자 전용) - 추가된 부분!
                case "/member/list.do":
                	// System.out.println("회원 리스트 진입 성공!");
                    // MemberListService를 실행하여 DB에서 회원 목록을 가져옴
                    request.setAttribute("list", Execute.execute(Init.getService(uri), null));
                    // /WEB-INF/views/member/list.jsp 로 이동
                    return "member/list";

                // 2. 로그인 폼
                case "/member/loginForm.do":
                	return "member/loginForm";

                	
                // 3. 로그인 처리
                case "/member/login.do":
                    LoginVO userVO = new LoginVO();
                    userVO.setId(request.getParameter("id"));
                    userVO.setPw(request.getParameter("pw"));
                    loginVO = (LoginVO) Execute.execute(Init.getService(uri), userVO);
                    if (loginVO == null)
                        throw new Exception("회원 정보를 확인하시고 다시 실행해 보세요.");
                    session.setAttribute("login", loginVO);
                    session.setAttribute("msg", "로그인이 되었습니다.");
                    return "redirect:/main/main.do";

                // 4. 로그아웃
                case "/member/logout.do":
                    session.removeAttribute("login");
                    session.setAttribute("msg", "로그아웃이 되었습니다.");
                    return "redirect:loginForm.do";

                // 5. 회원가입 폼dma 
                case "/member/writeForm.do":
                    return "member/writeForm";

                // 6. 회원가입 처리
                case "/member/write.do":
                    MemberVO vo = new MemberVO();
                    vo.setId(request.getParameter("id"));
                    vo.setPw(request.getParameter("pw"));
                    vo.setName(request.getParameter("name"));
                    vo.setGender(request.getParameter("gender"));
                    vo.setBirth(request.getParameter("birth"));
                    vo.setTel(request.getParameter("tel"));
                    vo.setEmail(request.getParameter("email"));
                    
                    Execute.execute(Init.getService(uri), vo);
                    
                    // 가입 즉시 로그인 처리용 세팅
                    loginVO = new LoginVO();
                    loginVO.setId(vo.getId());
                    loginVO.setName(vo.getName());
                    loginVO.setGradeNo(1);
                    loginVO.setGradeName("일반회원");
                    
                    session.setAttribute("login", loginVO);
                    session.setAttribute("msg", "축하드립니다. 회원가입이 되셨습니다.");
                    
                    return "redirect:" + request.getContextPath() + "/main/main.do";

                // 7. 내 정보보기
                case "/member/view.do":
                	
                result = Execute.execute(Init.getService(uri), loginId);
                System.out.println("가져온 데이터: " + result);
                request.setAttribute("vo", result);
                return "member/view";

                // 8. 회원정보 수정 폼
                case "/member/editForm.do":
                    request.setAttribute("vo", Execute.execute(Init.getService("/member/view.do"), loginId));
                    return "member/updateForm";

                // 9. 회원정보 수정 처리
                case "/member/edit.do":
                    vo = new MemberVO();
                    vo.setId(loginId);
                    vo.setName(request.getParameter("name"));
                    vo.setGender(request.getParameter("gender"));
                    vo.setBirth(request.getParameter("birth"));
                    vo.setTel(request.getParameter("tel"));
                    vo.setEmail(request.getParameter("email"));
                    Execute.execute(Init.getService(uri), vo);
                    session.setAttribute("msg", "회원의 정보가 수정되었습니다.");
                    return "redirect:/member/view.do";

                // 10. 비밀번호 변경
                case "/member/changePw.do":
                    vo = new MemberVO();
                    vo.setId(loginId);
                    vo.setPw(request.getParameter("pw"));
                    vo.setNewPw(request.getParameter("newPw"));
                    
                    System.out.println("변경 시도 아이디: " + loginId);
                    System.out.println("입력한 기존 비번: " + vo.getPw());
                    
                    intResult = (Integer) Execute.execute(Init.getService(uri), vo);
                    if (intResult == 1) {
                    	
                        session.removeAttribute("login");
                        return "redirect:/member/loginForm.do";
                 
                    } else {
                        throw new Exception("비밀번호 변경에 실패하였습니다. 기존 비밀번호를 확인해주세요.");
                    }

                // 11. 회원 탈퇴
                case "/member/delete.do":
                    vo = new MemberVO();
                    vo.setId(loginId);
                    vo.setPw(request.getParameter("pw"));
                    intResult = (Integer) Execute.execute(Init.getService(uri), vo);
                    if (intResult == 1) {
                        session.removeAttribute("login");
                        session.setAttribute("msg", "회원 탈퇴가 되었습니다.");
                        return "redirect:/";
                    } else {
                        throw new Exception("회원 탈퇴에 실패하였습니다.");
                    }

                // 12. 아이디 중복체크
                case "/member/checkId.do":
                    String id = request.getParameter("id");
                    request.setAttribute("id", Execute.execute(Init.getService(uri), id));
                    return "member/checkId";

                // 13. 회원 상태 변경 (관리자)
                case "/member/changeStatus.do":
                    vo = new MemberVO();
                    vo.setId(request.getParameter("id"));
                    if (vo.getId().equals(loginId)) {
                        session.setAttribute("msg", "로그인한 관리자의 상태는 변경할 수 없습니다.");
                        return "redirect:list.do";
                    }
                    vo.setStatus(request.getParameter("status"));
                    intResult = (Integer) Execute.execute(Init.getService(uri), vo);
                    if (intResult == 1) {
                        session.setAttribute("msg", vo.getId() + "의 상태가 " + vo.getStatus() + "으로 변경되었습니다.");
                    } else {
                        session.setAttribute("msg", "상태 변경에 실패하였습니다.");
                    }
                    return "redirect:/member/list.do";

                default:
                    return "error/noPage";
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("moduleName", "회원 관리");
            request.setAttribute("e", e);
            return "error/err_500";
        }
    }
}