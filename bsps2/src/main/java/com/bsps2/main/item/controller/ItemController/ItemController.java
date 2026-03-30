package com.bsps2.main.item.controller.ItemController; // 현재 폴더 구조에 맞춤

import java.util.Map;
import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO; // DAO 경로 맞춤
import com.bsps2.main.item.vo.ItemVO.ItemVO;   // VO 경로 맞춤
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class ItemController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        HttpSession session = request.getSession();
        try {
            String uri = request.getServletPath();
            Long no;
            
            switch (uri) {
                case "/item/list.do":
                    PageObject pageObject = new PageObject();
                    String strPage = request.getParameter("page");
                    String strPpn = request.getParameter("perPageNum");
                    pageObject.setPage((strPage != null && !strPage.equals("")) ? Long.parseLong(strPage) : 1L);
                    pageObject.setPerPageNum((strPpn != null && !strPpn.equals("")) ? Long.parseLong(strPpn) : 10L);

                    request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
                    request.setAttribute("pageObject", pageObject);
                    
                    // 통계 데이터 가져오기 (DAO 경로 주의)
                    ItemDAO dao = new ItemDAO(); 
                    request.setAttribute("meta", dao.getMetaData());
                    return "item/list";

                case "/item/view.do":
                    String noStr = request.getParameter("no");
                    if(noStr == null || noStr.equals("")) return "redirect:list.do";
                    request.setAttribute("vo", Execute.execute(Init.getService(uri), Long.parseLong(noStr)));
                    return "item/view";

                case "/item/writeForm.do":
                    return "item/writeForm";

                case "/item/write.do":
                    ItemVO vo = new ItemVO();
                    vo.setId("test_user");
                    vo.setName(request.getParameter("name"));
                    vo.setCategory(request.getParameter("category"));
                    vo.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                    vo.setUnit(request.getParameter("unit"));
                    vo.setPriority(request.getParameter("priority"));
                    vo.setExpiryDate(request.getParameter("expiryDate"));
                    vo.setMemo(request.getParameter("memo"));
                    vo.setIsReady(request.getParameter("isReady"));
                    
                    Execute.execute(Init.getService(uri), vo);
                    session.setAttribute("msg", "물품이 등록되었습니다.");
                    // 리다이렉트 시 안전하게 기본값 부여
                    String wPpn = request.getParameter("perPageNum");
                    if(wPpn == null || wPpn.equals("")) wPpn = "10";
                    return "redirect:list.do?perPageNum=" + wPpn;

                case "/item/updateForm.do":
                    no = Long.parseLong(request.getParameter("no"));
                    request.setAttribute("vo", Execute.execute(Init.getService("/item/view.do"), no));
                    return "item/updateForm";

                case "/item/update.do":
                    ItemVO uvo = new ItemVO();
                    uvo.setNo(Long.parseLong(request.getParameter("no")));
                    uvo.setName(request.getParameter("name"));
                    uvo.setCategory(request.getParameter("category"));
                    uvo.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                    uvo.setUnit(request.getParameter("unit"));
                    uvo.setPriority(request.getParameter("priority"));
                    uvo.setExpiryDate(request.getParameter("expiryDate"));
                    uvo.setMemo(request.getParameter("memo"));
                    uvo.setIsReady(request.getParameter("isReady"));
                    
                    Execute.execute(Init.getService(uri), uvo);
                    session.setAttribute("msg", "정보가 수정되었습니다.");
                    
                    // 수정 후 리스트로 넘어가기 위한 파라미터 처리
                    String uPpn = request.getParameter("perPageNum");
                    if(uPpn == null || uPpn.equals("")) uPpn = "10";
                    return "redirect:list.do?perPageNum=" + uPpn;

                case "/item/delete.do":
                    no = Long.parseLong(request.getParameter("no"));
                    Execute.execute(Init.getService(uri), no);
                    session.setAttribute("msg", "삭제되었습니다.");
                    return "redirect:list.do?perPageNum=10";
                    
                case "/item/changeReady.do":
                    no = Long.parseLong(request.getParameter("no"));
                    String isReady = request.getParameter("isReady");
                    
                    // DAO에 상태 변경 메서드 호출 (아래 2번에서 만들 예정)
                    ItemDAO readyDao = new ItemDAO();
                    readyDao.changeReady(no, isReady);
                    
                    session.setAttribute("msg", "물품 상태가 변경되었습니다.");
                    // 다시 상세보기 화면으로 리다이렉트
                    return "redirect:view.do?no=" + no + "&page=" + request.getParameter("page") + "&perPageNum=" + request.getParameter("perPageNum");

                default: return "error/noPage";
            }
        } catch (Exception e) { e.printStackTrace(); return "error/err_500"; }
    }
}