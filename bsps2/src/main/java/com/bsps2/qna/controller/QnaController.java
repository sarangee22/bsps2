package com.bsps2.qna.controller;

import com.bsps2.qna.vo.QnaVO;
import com.bsps2.util.page.PageObject;

import java.util.List;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.controller.Main;
import com.bsps2.main.service.Execute;
import com.bsps2.member.vo.LoginVO;

import jakarta.servlet.http.HttpServletRequest;

// Controller
//  - 예외 처리 - 위의 정상 처리를 try로 묶는다. catch로 예외 처리를 한다.
//  - 모듈(질문답변)을 처리한다...
//  - 데이터 수집 : DB에서 가져온다. 사용자에게 입력 받는다.
// Main - (QnaController) - QnaListService - QnaDAO // QnaVO
public class QnaController implements Controller{

	// PL이 메서드 이름을 정한다.
	// String 리턴 타입의 데이터는 forward 시킬 JSP의 정보이거나 redirect시킬 정보이다. 
	public String execute(HttpServletRequest request) {
		try { // 정상처리
			// 요청 uri에 따라서 처리된다.
			// list - /qna/list.do
			// 1. 질문답변 메뉴 입력
			String uri = request.getServletPath();
			
			// 2. 질문답변 메뉴 처리
			// 사용 변수 선언
			QnaVO vo;
			Integer result;
			Long no1;
			int inc;
			
			switch (uri) {
			// QnaController.java의 case "/qna/list.do": 부분
			case "/qna/list.do":
			    String word = request.getParameter("searchKeyword");
			    String pageStr = request.getParameter("page");
			    int page = (pageStr == null || pageStr.equals("")) ? 1 : Integer.parseInt(pageStr);
			    int perPage = 7; // 페이지당 10개
			    
			    List<com.bsps2.qna.vo.QnaVO> allList = 
			        (List<com.bsps2.qna.vo.QnaVO>) Execute.execute(Init.getService(uri), word);
			    
			    // 페이징 처리
			    int totalCount = allList.size();
			    int startIdx = (page - 1) * perPage;
			    int endIdx = Math.min(startIdx + perPage, totalCount);
			    List<com.bsps2.qna.vo.QnaVO> pageList = allList.subList(startIdx, endIdx);
			    
			    int totalPage = (int) Math.ceil((double) totalCount / perPage);
			    
			    request.setAttribute("list", pageList);
			    request.setAttribute("totalPage", totalPage);
			    request.setAttribute("curPage", page);
			    return "qna/list";

            case "/qna/view.do":
                no1 = Long.parseLong(request.getParameter("no"));
                inc = Integer.parseInt(request.getParameter("inc"));
                // Object 배열로 서비스에 전달
                request.setAttribute("vo", Execute.execute(Init.getService(uri), new Long[]{no1, (long)inc}));
                return "qna/view";
                
            case "/qna/questionForm.do":
                return "qna/questionForm";
                
            case "/qna/question.do":
                vo = new QnaVO();
                vo.setTitle(request.getParameter("title"));
                vo.setContent(request.getParameter("content"));

                com.bsps2.member.vo.LoginVO login = (com.bsps2.member.vo.LoginVO) request.getSession().getAttribute("login");
                
                if (login != null) {
                    // 로그인 상태라면 로그인한 사람의 ID를 세팅!
                    vo.setId(login.getId()); 
                } else {
                    
                    vo.setId("admin");
                }

                Execute.execute(Init.getService(uri), vo);
                request.getSession().setAttribute("msg", "새로운 글이 등록되었습니다.");
                return "redirect:list.do";
                
            case "/qna/answerForm.do":
                // 1. 변수 선언(Long) 없이 이미 만들어둔 no1을 사용합니다.
                no1 = Long.parseLong(request.getParameter("no"));
                // 2. [번호, inc] 배열로 전달 (상세보기 서비스와 규격 맞춤)
                request.setAttribute("vo", Execute.execute(Init.getService("/qna/view.do"), new Long[]{no1, 0L}));
                return "qna/answerForm";

            case "/qna/answer.do":
                vo = new QnaVO();
                vo.setTitle(request.getParameter("title"));
                vo.setContent(request.getParameter("content"));
                // 세션에서 로그인 정보 꺼내기
                LoginVO loginUser = (LoginVO)request.getSession().getAttribute("login");
                vo.setId(loginUser.getId());

                // 족보 세팅
                vo.setRefNo(Long.parseLong(request.getParameter("refNo")));
                vo.setOrdNo(Long.parseLong(request.getParameter("ordNo")) + 1);
                vo.setLevNo(Long.parseLong(request.getParameter("levNo")) + 1);
                vo.setParentNo(Long.parseLong(request.getParameter("no")));
                Execute.execute(Init.getService(uri), vo);
                return "redirect:list.do";
                
            case "/qna/updateForm.do":
                // 여기도 Long 빼고 no1만 씁니다.
                no1 = Long.parseLong(request.getParameter("no"));
                // 역시 배열로 전달
                request.setAttribute("vo", Execute.execute(Init.getService("/qna/view.do"), new Long[]{no1, 0L}));
                return "qna/updateForm";
                
            case "/qna/update.do":
                vo = new QnaVO();
                vo.setNo(Long.parseLong(request.getParameter("no")));
                vo.setTitle(request.getParameter("title"));
                vo.setContent(request.getParameter("content"));
                
                // 비밀번호 검증 추가
                String inputPw = request.getParameter("pw");
                LoginVO loginUser2 = (LoginVO) request.getSession().getAttribute("login");
                com.bsps2.member.vo.MemberVO memberInfo = new com.bsps2.member.dao.MemberDAO().view(loginUser2.getId());
                
                if(!memberInfo.getPw().equals(inputPw)) {
                    request.getSession().setAttribute("msg", "수정에 실패하였습니다. 비밀번호를 확인해주세요.");
                    return "redirect:updateForm.do?no=" + vo.getNo();
                }
                
                Execute.execute(Init.getService(uri), vo);
                request.getSession().setAttribute("msg", "글 수정이 되었습니다.");
                return "redirect:view.do?no=" + vo.getNo() + "&inc=0";
          
			
		 case "/qna/delete.do":
		    no1 = Long.parseLong(request.getParameter("no"));
		    String delPw = request.getParameter("pw");
		    LoginVO loginDel = (LoginVO) request.getSession().getAttribute("login");
		    com.bsps2.member.vo.MemberVO delMember = new com.bsps2.member.dao.MemberDAO().view(loginDel.getId());
		    
		    if(delPw == null || !delMember.getPw().equals(delPw)) {
		        request.getSession().setAttribute("msg", "삭제에 실패하였습니다. 비밀번호를 확인해주세요.");
		        return "redirect:view.do?no=" + no1 + "&inc=0";
		    }
		    
		    result = (Integer) Execute.execute(Init.getService(uri), no1);
		    if(result == 1) {
		        request.getSession().setAttribute("msg", "삭제가 되었습니다.");
		        return "redirect:list.do";
		    } else {
		        request.getSession().setAttribute("msg", "삭제에 실패하였습니다.");
		        return "redirect:view.do?no=" + no1 + "&inc=0";
		    }
		    
		 default:
		        request.setAttribute("url", request.getRequestURL());
		        return "error/noPage";
		 }
			
			} catch (Exception e) { // 예외 처리
			e.printStackTrace(); // 개발자를 위한 예외 상세 출력
			// 잘못된 예외 처리 - 사용자에게 보여주기
			request.setAttribute("url", request.getRequestURL());
			request.setAttribute("moduleName", "질문 답변");
			request.setAttribute("e", e);
			// /WEB-INF/views/ + error/err_500 + .jsp
			return "error/err_500";
		} // catch 의 끝
			// return null;

	} // execute()의 끝

}// 클래스의 끝