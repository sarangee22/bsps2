package com.bsps2.member.controller;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.member.vo.LoginVO;
import com.bsps2.member.vo.MemberVO;
import com.bsps2.util.page.PageObject;

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

			  // 0. 관리자 메인 (대시보드)....
			  case "/admin/main.do":
				// 관리자가 아니면 못 들어오게 막는 로직 (보안!)
				if (loginVO == null || loginVO.getGradeNo() != 9) {
					throw new Exception("관리자 권한이 필요한 페이지입니다.");
				}
				
				// 관리자 메인에서도 페이징 객체를 생성해서 넘겨줘야 리스트가 정상 출력됩니다.
			    PageObject adminPageObject = PageObject.getInstance(request);
			    adminPageObject.setAccepter(loginId);
			    Object listData = Execute.execute(Init.getService("/member/list.do"), adminPageObject);
			    request.setAttribute("list", listData);
			    request.setAttribute("pageObject", adminPageObject); // 페이징 객체 추가
			    return "loginAdmin/main"; // views/loginAdmin/main.jsp 로 이동
            
				// 1. 회원 리스트 (관리자 전용)..
			  case "/member/list.do":
			      // [추가] 페이징 및 검색을 위한 객체 생성
			      // 웹에서 넘어오는 page, perPageNum, key, word 데이터를 자동으로 세팅합니다.
			      PageObject pageObject = PageObject.getInstance(request);
			      
			      // [요구사항 반영] 로그인한 관리자 아이디는 제외하기 위해 추가 (필요 시 서비스/DAO에서 처리)
			      // pageObject에 현재 로그인한 id를 담아 보내면 쿼리에서 제외하기 편합니다.
			      pageObject.setAccepter(loginId); 

			      // [수정] Execute 실행 시 null 대신 pageObject를 인자로 넘깁니다.
			      result = Execute.execute(Init.getService(uri), pageObject);
			      
			      // JSP에서 사용할 데이터 세팅
			      request.setAttribute("list", result);
			      request.setAttribute("pageObject", pageObject); // 페이지 번호를 그리기 위해 필요
			      
			      return "loginAdmin/main";

                // 2. 로그인 폼
                case "/member/loginForm.do":
                	return "member/loginForm";

                	
                	// 3. 로그인 처리..
                case "/member/login.do":
                    LoginVO userVO = new LoginVO();
                    userVO.setId(request.getParameter("id"));
                    userVO.setPw(request.getParameter("pw"));
                    
                    loginVO = (LoginVO) Execute.execute(Init.getService(uri), userVO);
                    
                    // [중요] 로그인 실패 시 처리
                    if (loginVO == null) {
                        // 예외를 던지지(throw) 않고, 메시지만 세션에 담아서 다시 로그인 폼으로 보냅니다.
                        session.setAttribute("msg", "로그인 정보가 일치하지 않습니다. 다시 시도해주세요.");
                        return "redirect:/member/loginForm.do"; 
                    }
                    
                    new com.bsps2.member.dao.MemberDAO().updateConDate(userVO.getId());

                    // 로그인 성공 시 (loginVO가 null이 아닐 때만 아래가 실행됨)
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

                // 10. 비밀번호 변경 폼
                case "/member/changePwForm.do":
                    return "member/pwChange";
                 
                    
                 // 10-1. 비밀번호 변경 처리 
                case "/member/changePw.do":
                    vo = new MemberVO();
                    vo.setId(loginId);
                    vo.setPw(request.getParameter("pw"));
                    vo.setNewPw(request.getParameter("newPw"));
                    
                    // 로그 찍어보기 (값이 잘 들어오는지 콘솔에서 확인용)
                    System.out.println("전달된 아이디: " + vo.getId());
                    System.out.println("전달된 기존비번: " + vo.getPw());
                    System.out.println("전달된 새비번: " + vo.getNewPw());
                    
                    // 여기서 DB를 실행합니다.
                    intResult = (Integer) Execute.execute(Init.getService(uri), vo);
                    if (intResult == 1) {
                        session.removeAttribute("login");
                        session.setAttribute("msg", "비밀번호가 변경되었습니다. 다시 로그인해주세요.");
                        return "redirect:/member/loginForm.do";
                    } else {
                        session.setAttribute("msg", "비밀번호 변경에 실패하였습니다. 기존 비밀번호를 확인해주세요.");
                        return "redirect:/member/changePwForm.do";
                    }
                    
                // 11. 회원 탈퇴 폼
                case "/member/deleteForm.do":
                       return "member/delete";
                       
                // 11-1. 회원 탈퇴 처리 
                case "/member/delete.do":
                    vo = new MemberVO();
                    vo.setId(loginId);
                    vo.setPw(request.getParameter("pw"));
                    
                    intResult = (Integer) Execute.execute(Init.getService(uri), vo);
                    if (intResult == 1) {
                        session.removeAttribute("login");
                        session.setAttribute("msg", "회원 탈퇴가 완료되었습니다.");
                        return "redirect:/main/main.do";
                    } else {
                        session.setAttribute("msg", "비밀번호 변경에 실패하였습니다. 기존 비밀번호를 확인해주세요.");
                        return "redirect:/member/changePwForm.do";
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