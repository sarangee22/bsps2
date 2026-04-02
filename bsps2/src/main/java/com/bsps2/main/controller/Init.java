package com.bsps2.main.controller;

import java.util.HashMap;
import java.util.Map;

import com.bsps2.community.controller.CommunityController;
import com.bsps2.community.dao.CommunityDAO;
import com.bsps2.community.service.CommunityChangeImageService;
import com.bsps2.community.service.CommunityDeleteService;
import com.bsps2.community.service.CommunityListService;
import com.bsps2.community.service.CommunityUpdateService;
import com.bsps2.community.service.CommunityViewService;
import com.bsps2.community.service.CommunityWriteService;
import com.bsps2.disasterCategory.controller.DisasterCategoryController;
import com.bsps2.disasterCategory.dao.DisasterCategoryDAO;
import com.bsps2.disasterCategory.service.DisasterCategoryService;
import com.bsps2.disasterList.controller.DisasterListController;
import com.bsps2.disasterList.dao.DisasterListDAO;
import com.bsps2.disasterList.service.DisasterListService;
import com.bsps2.disasterMap.controller.DisasterMapController;
import com.bsps2.disasterMap.dao.DisasterMapDAO;
import com.bsps2.disasterMap.service.DisasterMapDeleteService;
import com.bsps2.disasterMap.service.DisasterMapListService;
import com.bsps2.disasterMap.service.DisasterMapUpdateService;
import com.bsps2.disasterMap.service.DisasterMapViewService;
import com.bsps2.disasterMap.service.DisasterMapWriteService;
import com.bsps2.disasterSafe.controller.AgencyController;
import com.bsps2.disasterSafe.dao.AgencyDAO;
import com.bsps2.disasterSafe.service.AgencyDeleteService;
import com.bsps2.disasterSafe.service.AgencyListService;
import com.bsps2.disasterSafe.service.AgencyUpdateService;
import com.bsps2.disasterSafe.service.AgencyViewService;
import com.bsps2.disasterSafe.service.AgencyWriteService;
import com.bsps2.disasterSafe.service.AgencyListService;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.edu.controller.EduController.EduController;
import com.bsps2.main.edu.dao.EduDAO.EduDAO;
import com.bsps2.main.edu.service.EduService.EduDeleteService;
import com.bsps2.main.edu.service.EduService.EduListService;
import com.bsps2.main.edu.service.EduService.EduViewService;
import com.bsps2.main.edu.service.EduService.EduWriteService;
import com.bsps2.main.item.controller.ItemController.ItemController;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO;
import com.bsps2.main.item.service.ItemDeleteService.ItemDeleteService;
import com.bsps2.main.item.service.ItemDeleteService.ItemListService;
import com.bsps2.main.item.service.ItemDeleteService.ItemUpdateService;
import com.bsps2.main.item.service.ItemDeleteService.ItemViewService;
import com.bsps2.main.item.service.ItemDeleteService.ItemWriteService;
import com.bsps2.main.service.Service;
import com.bsps2.member.controller.MemberController;
import com.bsps2.member.dao.MemberDAO;
import com.bsps2.member.service.LoginService;
import com.bsps2.member.service.LogoutService;
import com.bsps2.member.service.MemberChangePwService;
import com.bsps2.member.service.MemberChangeStatueService;
import com.bsps2.member.service.MemberCheckIdService;
import com.bsps2.member.service.MemberDeleteService;
import com.bsps2.member.service.MemberEditService;
import com.bsps2.member.service.MemberListService;
import com.bsps2.member.service.MemberViewService;
import com.bsps2.member.service.MemberWriteService;
import com.bsps2.qna.controller.QnaController;
import com.bsps2.qna.dao.QnaDAO;
import com.bsps2.qna.service.QnaAnswerService;
import com.bsps2.qna.service.QnaDeleteService;
import com.bsps2.qna.service.QnaListService;
import com.bsps2.qna.service.QnaQuestionService;
import com.bsps2.qna.service.QnaUpdateService;
import com.bsps2.qna.service.QnaViewService;
import com.bsps2.quiz.controller.QuizController;
import com.bsps2.quiz.dao.QuizDAO;
import com.bsps2.quiz.service.QuizListService;
import com.bsps2.scrap.controller.ScrapController;
import com.bsps2.scrap.dao.ScrapDAO;
import com.bsps2.scrap.service.ScrapService;

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
		
		// *** 제보 게시판 생성 / 저장 / 조립
		// == controller 등록..
		controllerMap.put("/community", new CommunityController());
		// == service 등록
		serviceMap.put("/community/list.do", new CommunityListService());
		serviceMap.put("/community/view.do", new CommunityViewService());
		serviceMap.put("/community/write.do", new CommunityWriteService());
		serviceMap.put("/community/update.do", new CommunityUpdateService());
		serviceMap.put("/community/changeImage.do", new CommunityChangeImageService());
		serviceMap.put("/community/delete.do", new CommunityDeleteService());
		
		// == dao 등록
		daoMap.put("communityDAO", new CommunityDAO());
		// 조립 (service - dao)
		serviceMap.get("/community/list.do").setDAO(daoMap.get("communityDAO"));
		serviceMap.get("/community/view.do").setDAO(daoMap.get("communityDAO"));
		serviceMap.get("/community/write.do").setDAO(daoMap.get("communityDAO"));
		serviceMap.get("/community/update.do").setDAO(daoMap.get("communityDAO"));
		serviceMap.get("/community/changeImage.do").setDAO(daoMap.get("communityDAO"));
		serviceMap.get("/community/delete.do").setDAO(daoMap.get("communityDAO"));
		
		// *** 퀴즈 게시판 생성 / 저장 / 조립
		// == controller 등록..
		controllerMap.put("/quiz", new QuizController());
		// == service 등록
		serviceMap.put("/quiz/list.do", new QuizListService());
		// == dao 등록
		daoMap.put("quizDAO", new QuizDAO());
		// 조립 (service - dao)
		serviceMap.get("/quiz/list.do").setDAO(daoMap.get("quizDAO"));
		
		
		// --- 회원 관리 모듈 조립 (예시) ---
				// 1. DAO 생성
				MemberDAO memberDAO = new MemberDAO();
				
				// -- Controller 저장 - 모듈이름으로 저장
				controllerMap.put("/member", new MemberController());
				// -- Service 저장 - uri로 저장
				serviceMap.put("/member/login.do", new LoginService());
				// 최근 접속일 변경 - 외부 URI 없음. 내부 URI - /member/changeCon.do
				serviceMap.put("/member/write.do", new MemberWriteService());
				serviceMap.put("/member/view.do", new MemberViewService());
				serviceMap.put("/member/edit.do", new MemberEditService());
				serviceMap.put("/member/changePw.do", new MemberChangePwService());
				serviceMap.put("/member/delete.do", new MemberDeleteService());
				serviceMap.put("/member/changeStatus.do", new MemberChangeStatueService());
				serviceMap.put("/member/checkId.do", new MemberCheckIdService());
				serviceMap.put("/member/logout.do", new LogoutService());
				serviceMap.put("/member/list.do", new MemberListService());
				// -- DAO 저장 - 변수 이름
				daoMap.put("memberDAO", new MemberDAO());
				// 조립 service에 dao 넣기 - service를 가져온다. setter를 이용해서 가져온 dao를 넣는다.
				serviceMap.get("/member/login.do").setDAO(daoMap.get("memberDAO"));
				serviceMap.get("/member/write.do").setDAO(daoMap.get("memberDAO"));
				serviceMap.get("/member/view.do").setDAO(daoMap.get("memberDAO"));
				serviceMap.get("/member/edit.do").setDAO(daoMap.get("memberDAO"));
				serviceMap.get("/member/changePw.do").setDAO(daoMap.get("memberDAO"));
				serviceMap.get("/member/delete.do").setDAO(daoMap.get("memberDAO"));
				serviceMap.get("/member/changeStatus.do").setDAO(daoMap.get("memberDAO"));
				serviceMap.get("/member/checkId.do").setDAO(daoMap.get("memberDAO"));
				serviceMap.get("/member/logout.do").setDAO(daoMap.get("memberDAO"));
				serviceMap.get("/member/list.do").setDAO(daoMap.get("memberDAO"));
				
				// *** 질문 답변 생성 / 저장 / 조립
				// -- Controller 저장
				controllerMap.put("/qna", new QnaController());
				// -- Service 저장
				serviceMap.put("/qna/list.do", new QnaListService());
				serviceMap.put("qnaListService", new QnaListService());
				serviceMap.put("/qna/view.do", new QnaViewService());
				serviceMap.put("/qna/question.do", new QnaQuestionService());
				serviceMap.put("/qna/answer.do", new QnaAnswerService());
				serviceMap.put("/qna/update.do", new QnaUpdateService());
				serviceMap.put("/qna/delete.do", new QnaDeleteService());
				// -- DAO 저장
				daoMap.put("qnaDAO", new QnaDAO());
				// 조립 service에 dao 넣기 - service를 가져온다. setter를 이용해서 가져온 dao를 넣는다.
				serviceMap.get("/qna/list.do").setDAO(daoMap.get("qnaDAO"));
				serviceMap.get("/qna/view.do").setDAO(daoMap.get("qnaDAO"));
				serviceMap.get("/qna/question.do").setDAO(daoMap.get("qnaDAO"));
				serviceMap.get("/qna/answer.do").setDAO(daoMap.get("qnaDAO"));
				serviceMap.get("/qna/update.do").setDAO(daoMap.get("qnaDAO"));
				serviceMap.get("/qna/delete.do").setDAO(daoMap.get("qnaDAO"));
				
		// --- [비상물품 체크리스트 모듈 조립 시작] ---

		// 1. DAO 생성 및 저장
		// 클래스명이 ItemDAO이므로 키값은 "itemDAO"로 통일합니다.
		ItemDAO itemDAO = new ItemDAO();
		daoMap.put("itemDAO", itemDAO);

		// 2. Controller 생성 및 저장
		// DispatcherServlet이 "/item"으로 시작하는 모든 요청을 이 컨트롤러로 보냅니다.
		controllerMap.put("/item", new ItemController());

		// 3. Service 생성 / 저장 / 조립
		// 각 서비스 객체를 생성하고, 위에서 만든 itemDAO를 주입(Injection)합니다.

		// --- [리스트 서비스] ---
		ItemListService itemListService = new ItemListService();
		itemListService.setDAO(itemDAO); // 직접 변수를 넣어주는게 더 안전합니다.
		serviceMap.put("/item/list.do", itemListService);

		// --- [글보기 서비스] ---
		ItemViewService itemViewService = new ItemViewService();
		itemViewService.setDAO(itemDAO);
		serviceMap.put("/item/view.do", itemViewService);

		// --- [글등록 서비스] ---
		ItemWriteService itemWriteService = new ItemWriteService();
		itemWriteService.setDAO(itemDAO);
		serviceMap.put("/item/write.do", itemWriteService);

		// --- [글수정 서비스] ---
		ItemUpdateService itemUpdateService = new ItemUpdateService();
		itemUpdateService.setDAO(itemDAO);
		serviceMap.put("/item/update.do", itemUpdateService);

		// --- [글삭제 서비스] ---
		ItemDeleteService itemDeleteService = new ItemDeleteService();
		itemDeleteService.setDAO(itemDAO);
		serviceMap.put("/item/delete.do", itemDeleteService);

		System.out.println("Init.init() --- 비상물품 모듈(MVC) 조립 완료 ---");
		
		// edu
		// Init.java의 init() 메서드 안에 추가하세요.

		// --- [교육 가이드 모듈 조립 시작] ---
		EduDAO eduDAO = new EduDAO();
		EduController eduCtrl = new EduController();

		// 1. 컨트롤러 등록
		controllerMap.put("/edu", eduCtrl);
		controllerMap.put("/admin/edu", eduCtrl);

		// 2. 서비스 생성 (변수에 담아서 재사용하는 것이 안전합니다)
		EduListService eduListService = new EduListService();
		EduViewService eduViewService = new EduViewService();
		EduWriteService eduWriteService = new EduWriteService();
		EduDeleteService eduDeleteService = new EduDeleteService();

		// 3. 서비스에 DAO 주입 (실행 전 반드시 필요)
		eduListService.setDAO(eduDAO);
		eduViewService.setDAO(eduDAO);
		eduWriteService.setDAO(eduDAO);
		eduDeleteService.setDAO(eduDAO);   

		// 4. 서비스 맵(serviceMap)에 등록
		serviceMap.put("/edu/list.do", eduListService);
		serviceMap.put("/admin/edu/list.do", eduListService); // 관리자 리스트용 추가!
		serviceMap.put("/edu/view.do", eduViewService);
		serviceMap.put("/admin/edu/view.do", eduViewService); // 관리자용 상세보기도 필요할 수 있음
		serviceMap.put("/admin/edu/write.do", eduWriteService);
		serviceMap.put("/admin/edu/delete.do", eduDeleteService);

		System.out.println("Init.init() --- 교육 모듈 MVC 조립 완료 ---");
		
		//map controller
		controllerMap.put("/disasterMap", new DisasterMapController());

		// 2. DAO 등록 (이것도 맞음)
		daoMap.put("disasterMapDAO", new DisasterMapDAO());

		// 3. Service 등록 (이 부분을 수정해야 함)
		// Controller가 아니라 각각의 Service 클래스를 생성해서 넣어야 합니다.
		serviceMap.put("/disasterMap/list.do", new DisasterMapListService());
		serviceMap.put("/disasterMap/view.do", new DisasterMapViewService());
		serviceMap.put("/disasterMap/write.do", new DisasterMapWriteService());
		serviceMap.put("/disasterMap/update.do", new DisasterMapUpdateService());
		serviceMap.put("/disasterMap/delete.do", new DisasterMapDeleteService());

		// 4. 조립 (Service에 DAO 주입)
		serviceMap.get("/disasterMap/list.do").setDAO(daoMap.get("disasterMapDAO"));
		serviceMap.get("/disasterMap/view.do").setDAO(daoMap.get("disasterMapDAO"));
		serviceMap.get("/disasterMap/write.do").setDAO(daoMap.get("disasterMapDAO"));
		serviceMap.get("/disasterMap/update.do").setDAO(daoMap.get("disasterMapDAO"));
		serviceMap.get("/disasterMap/delete.do").setDAO(daoMap.get("disasterMapDAO"));
		
		daoMap.put("agencyDAO", new AgencyDAO());
		
		// 2. Controller 생성 및 저장
		controllerMap.put("/agency", new AgencyController());
		
		// 3. Service 생성 및 DAO 주입 (Setter 호출)
		// 리스트
		Service agencyListService = new AgencyListService();
		agencyListService.setDAO(daoMap.get("agencyDAO"));
		serviceMap.put("/agency/list.do", agencyListService);
		
		// 상세보기
		Service agencyViewService = new AgencyViewService();
		agencyViewService.setDAO(daoMap.get("agencyDAO"));
		serviceMap.put("/agency/view.do", agencyViewService);
		
		// 등록
		Service agencyWriteService = new AgencyWriteService();
		agencyWriteService.setDAO(daoMap.get("agencyDAO"));
		serviceMap.put("/agency/write.do", agencyWriteService);
		
		// 수정
		Service agencyUpdateService = new AgencyUpdateService();
		agencyUpdateService.setDAO(daoMap.get("agencyDAO"));
		serviceMap.put("/agency/update.do", agencyUpdateService);
		
		// 삭제
		Service agencyDeleteService = new AgencyDeleteService();
		agencyDeleteService.setDAO(daoMap.get("agencyDAO"));
		serviceMap.put("/agency/delete.do", agencyDeleteService);
		
		System.out.println("Init.init() : 재난 안전 기관(Agency) 모듈 조립 완료 ----------------");

		// *** 재난안전 정보 카테고리 생성 / 저장 / 조립
		// 1. DAO 생성 및 저장
		// disasterCetegory.dao.DisasterCetegoryDAO
		DisasterCategoryDAO disasterCategoryDAO = new DisasterCategoryDAO();
		daoMap.put("disasterCategoryDAO", disasterCategoryDAO);

		// 2. Service 생성 및 저장
		// disasterCetegory.service.DisasterCetegoryService
		DisasterCategoryService disasterCategoryService = new DisasterCategoryService();
		serviceMap.put("/disasterCategory/list.do", disasterCategoryService);

		// 3. 조립: service에 dao 넣기
		// -- service를 가져온다. setter를 이용해서 생성한 dao를 넣는다.
		disasterCategoryService.setDAO(disasterCategoryDAO);

		// 4. Controller 저장
		// disasterCetegory.controller.DisasterCetegoryController
		controllerMap.put("/disasterCategory", new DisasterCategoryController());
		
		
		// *** 재난안전 리스트 & 상세보기 조립 ***

		// 1. DAO 생성 및 저장 (딱 하나만 만듭니다)
		DisasterListDAO disasterListDAO = new DisasterListDAO();
		daoMap.put("disasterListDAO", disasterListDAO);

		// 2. Service 생성 및 저장 (하나의 서비스 객체로 리스트/상세보기 둘 다 처리)
		DisasterListService disasterListService = new DisasterListService();

		// 실행 시 사용될 URI와 서비스를 매핑합니다.
		serviceMap.put("/disasterList/list.do", disasterListService);
		serviceMap.put("/disasterList/view.do", disasterListService);

		// 3. 조립: Service에 DAO 넣기 
		// (중요: 위에서 생성한 disasterListService에 직접 넣어주면 
		// serviceMap에 들어있는 객체에도 자동으로 적용됩니다.)
		disasterListService.setDAO(disasterListDAO);

		// 4. Controller 저장
		controllerMap.put("/disasterList", new DisasterListController());
		
		
		// ------ [스크랩 모듈 조립 시작] ------
		// 1. DAO 생성 및 저장
		// 패키지: com.bsps2.scrap.dao.ScrapDAO
		ScrapDAO scrapDAO = new ScrapDAO();
		daoMap.put("scrapDAO", scrapDAO);

		// 2. Service 생성 및 저장
		// 패키지: com.bsps2.scrap.service.ScrapService
		ScrapService scrapService = new ScrapService();
		// 리스트, 저장, 삭제 모두 하나의 서비스에서 처리하도록 매핑합니다.
		serviceMap.put("/scrap/list.do", scrapService);
		serviceMap.put("/scrap/scrap.do", scrapService);
		serviceMap.put("/scrap/delete.do", scrapService);

		// 3. 조립: Service에 DAO 넣기
		// ScrapService의 setDAO(DAO dao) 메서드를 호출합니다.
		scrapService.setDAO(scrapDAO);

		// 4. Controller 저장
		// 패키지: com.bsps2.scrap.controller.ScrapController
		// URI가 "/scrap"으로 시작하면 이 컨트롤러가 실행됩니다.
		controllerMap.put("/scrap", new ScrapController());

	}
}
