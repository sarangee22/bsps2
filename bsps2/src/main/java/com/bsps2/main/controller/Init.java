package com.bsps2.main.controller;

import java.util.HashMap;
import java.util.Map;

import com.bsps2.community.controller.CommunityController;
import com.bsps2.community.dao.CommunityDAO;
import com.bsps2.community.service.CommunityDeleteService;
import com.bsps2.community.service.CommunityListService;
import com.bsps2.community.service.CommunityUpdateService;
import com.bsps2.community.service.CommunityViewService;
import com.bsps2.community.service.CommunityWriteService;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.controller.ItemController.ItemController;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO;
import com.bsps2.main.item.service.ItemDeleteService.ItemDeleteService;
import com.bsps2.main.item.service.ItemDeleteService.ItemListService;
import com.bsps2.main.item.service.ItemDeleteService.ItemUpdateService;
import com.bsps2.main.item.service.ItemDeleteService.ItemViewService;
import com.bsps2.main.item.service.ItemDeleteService.ItemWriteService;
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
		serviceMap.put("/community/view.do", new CommunityViewService());
		serviceMap.put("/community/write.do", new CommunityWriteService());
		serviceMap.put("/community/update.do", new CommunityUpdateService());
		serviceMap.put("/community/delete.do", new CommunityDeleteService());
		
		// == dao 등록
		daoMap.put("communityDAO", new CommunityDAO());
		// 조립 (service - dao)
		serviceMap.get("/community/list.do").setDAO(daoMap.get("communityDAO"));
		serviceMap.get("/community/view.do").setDAO(daoMap.get("communityDAO"));
		serviceMap.get("/community/write.do").setDAO(daoMap.get("communityDAO"));
		serviceMap.get("/community/update.do").setDAO(daoMap.get("communityDAO"));
		serviceMap.get("/community/delete.do").setDAO(daoMap.get("communityDAO"));
		
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
		
		// 비상물품 체크리스트 
		// 1. DAO 생성 및 저장
				// key값은 나중에 꺼내기 쉽도록 "소문자 시작 클래스명"으로 저장합니다.
				ItemDAO itemDAO = new ItemDAO();
				daoMap.put("itemDAO", itemDAO);
				
				// 2. Controller 생성 및 저장
				// 모듈 이름인 "/item"을 key로 저장하여 DispatcherServlet이 찾게 합니다.
				controllerMap.put("/item", new ItemController());
				
				// 3. Service 생성 / 저장 / 조립
				// --- [비상물품 리스트] ---
				serviceMap.put("/item/list.do", new ItemListService());
				serviceMap.get("/item/list.do").setDAO(daoMap.get("itemDAO"));
				
				// --- [비상물품 보기] ---
				serviceMap.put("/item/view.do", new ItemViewService());
				serviceMap.get("/item/view.do").setDAO(daoMap.get("itemDAO"));
				
				// --- [비상물품 등록] ---
				serviceMap.put("/item/write.do", new ItemWriteService());
				serviceMap.get("/item/write.do").setDAO(daoMap.get("itemDAO"));
				
				// --- [비상물품 수정] ---
				serviceMap.put("/item/update.do", new ItemUpdateService());
				serviceMap.get("/item/update.do").setDAO(daoMap.get("itemDAO"));
				
				// --- [비상물품 삭제] ---
				serviceMap.put("/item/delete.do", new ItemDeleteService());
				serviceMap.get("/item/delete.do").setDAO(daoMap.get("itemDAO"));
				
				System.out.println("Init.init() --- 비상물품 모듈 조립 완료 ---");

	}

}
