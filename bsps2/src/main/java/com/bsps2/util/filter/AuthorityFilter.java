package com.bsps2.util.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
// import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.bsps2.member.vo.LoginVO;




/**
 * Servlet Filter implementation class AutorityFilter
 */
// @WebFilter("/AutorityFilter") -> web.xml에 설정. 여기는 반드시 주석처리한다.
public class AuthorityFilter extends HttpFilter implements Filter {
       
	private static final long serialVersionUID = 1L;

	private Map<String, Integer> authMap = new HashMap<>();
	
	/**
     * @see HttpFilter#HttpFilter()
     */
    public AuthorityFilter() { // 생성자
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() { // 소멸자
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 * 
	 * 필터 처리 메서드 - request, response 타입이 다르다.
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here - 실행 전 필터 처리 : 권한 처리
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		String uri = req.getServletPath();
		
		System.out.println("AutorityFilter.doFilter().uri : " + uri);
		
		System.out.println("AutorityFilter.doFilter() 실행전 처리 : 권한 처리 ----------------------");

		Integer pageGradeNo = authMap.get(uri);
		
		if(pageGradeNo != null) {
			// 사용자가 로그인 처리가 되어 있어야만 한다.
			// 1. 로그인 정보를 가져온다.
			HttpSession session = req.getSession();
			LoginVO login = (LoginVO) session.getAttribute("login");
			// 2. 로그인이 안되었을 때 로그인 하라고 시킨다.
			if(login == null) {
				// 메시지 처리
				session.setAttribute("msg", "로그인이 필요한 페이지입니다.");
				res.sendRedirect("/member/loginForm.do");
				return;
			} // 로그인이 안되었을 때의 처리 끝
			
			// 로그인이 되었을 때의 관리자 처리
			if(pageGradeNo == 9) {
				// 관리자 권한이 아닌 경우의 처리 - 일반 회원인 경우(1)
				if(login.getGradeNo() < pageGradeNo) {
					req.setAttribute("url", req.getRequestURL());
					req.getRequestDispatcher("/WEB-INF/views/error/auth.jsp").forward(req, res);
					return;
				} // 관리자 권한 if의 끝
			} // 페이지의 권한이 관리자인 경우 끝
			
		} // if(pageGradeNo != null) 의 끝
		
		// pass the request along the filter chain
		chain.doFilter(request, response); // 요청에 따른 실제적인 실행
		
		// 실행 후 필터 처리
	}

	/**
	 * @see Filter#init(FilterConfig)
	 * 모든 페이지에 대한 권한 저장
	 */
	public void init(FilterConfig fConfig) throws ServletException {

		System.out.println("AutorityFilter.init()-------------------");
		
		// --- [회원 관리] 권한 설정 ---
		authMap.put("/member/view.do", 1);
		authMap.put("/member/editForm.do", 1);
		authMap.put("/member/edit.do", 1);
		authMap.put("/member/changePwForm.do", 1);
		authMap.put("/member/changePw.do", 1);
		authMap.put("/member/deleteForm.do", 1);
		authMap.put("/member/delete.do", 1);
		
		// 관리자 전용 회원 관리
		authMap.put("/member/list.do", 9);
		authMap.put("/member/changeStatus.do", 9);
		authMap.put("/admin/main.do", 9);
		
		// --- [퀴즈 게시판] 권한 설정 ---
		// 퀴즈 등록/수정/삭제는 오직 관리자(9)만 가능
		authMap.put("/quiz/writeForm.do", 9);
		authMap.put("/quiz/write.do", 9);
		authMap.put("/quiz/updateForm.do", 9);
		authMap.put("/quiz/update.do", 9);
		authMap.put("/quiz/delete.do", 9);

		// --- [제보 게시판(Community)] 권한 설정 ---
		// 등록/수정/삭제는 로그인한 회원(1) 이상 가능
		// (작성자 본인 확인은 Controller에서 추가로 진행)
		authMap.put("/community/writeForm.do", 1);
		authMap.put("/community/write.do", 1);
		authMap.put("/community/updateForm.do", 1);
		authMap.put("/community/update.do", 1);
		authMap.put("/community/delete.do", 1);
	}

}
