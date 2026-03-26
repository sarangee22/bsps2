package com.bsps2.main.controller;

import java.util.HashMap;
import java.util.Map;

import com.bsps2.community.controller.CommunityController;
import com.bsps2.community.dao.CommunityDAO;
import com.bsps2.community.service.CommunityListService;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
// import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

/**
 * Servlet implementation class Init
 */
// DB 클래스 확인, 객체 생성 / 저장 / 조립
// @WebServlet("/Init")
public class Init extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 생성된 객체를 저장하는 변수 선언 ----------------------------------
	// Controller를 저장하는 변수 - 모듈명으로 저장
	private static Map<String, Controller> controllerMap = new HashMap<>();
	// Service를 저장하는 변수 - URI로 저장
	private static Map<String, Service> serviceMap = new HashMap<>();
	// DAO를 저장하는 변수 - 클래스이름 앞 부분 소문자로 저장
	private static Map<String, DAO> daoMap = new HashMap<>();
	
	// Controller 저장변수에서 Controller를 꺼내가는 메서드
	public static Controller getController(String module) {
		return controllerMap.get(module);
	}
	
	// Service 저장변수에서 Service를 꺼내가는 메서드
	public static Service getService(String uri) {
		return serviceMap.get(uri);
	}
	
    /**
     * Default constructor. 
     */
    public Init() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
    // 서버가 돌아갈 때 실행되도록 하고 싶다.
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("Init.init()-----------------------------------------------------");
		// 1. 생성하고, 2 저장 - map, 3. 조립
		// 생성해서 저장해 놓는다.
		
		// *** 메인 등록
		// == controller는 모듈명으로 저장
		
		// *** 일반 게시판 생성 / 저장 / 조립
		// == controller 등록
		controllerMap.put("/community", new CommunityController());
		// == service 등록
		serviceMap.put("/community/list.do", new CommunityListService());
		
		// == dao 등록
		daoMap.put("CommunityDAO", new CommunityDAO());
		// 조립 (service - dao)
		serviceMap.get("/community/list.do").setDAO(daoMap.get("communityDAO"));
		
		// *** 회원관리 생성 / 저장 / 조립
		// -- Controller 저장 - 모듈이름으로 저장
		// -- Service 저장 - uri로 저장
		// 최근 접속일 변경 - 외부 URI 없음. 내부 URI - /member/changeCon.do
		// -- DAO 저장 - 변수 이름
		// 조립 service에 dao 넣기 - service를 가져온다. setter를 이용해서 가져온 dao를 넣는다.
		
		// *** 질문 답변 생성 / 저장 / 조립
		// -- Controller 저장
		// -- Service 저장
		// -- DAO 저장
		// 조립 service에 dao 넣기 - service를 가져온다. setter를 이용해서 가져온 dao를 넣는다.
		

	}

}
