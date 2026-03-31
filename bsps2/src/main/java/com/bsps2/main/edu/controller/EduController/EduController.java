package com.bsps2.main.edu.controller.EduController;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.edu.dao.EduDAO.EduDAO;
import com.bsps2.main.edu.vo.EduVO.EduVO;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;

public class EduController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        try {
            String uri = request.getServletPath();
            EduDAO dao = new EduDAO(); // 통계(meta) 및 기본 데이터 처리를 위한 DAO
            
            switch (uri) {
                // 1. 가이드 목록 (사용자/관리자 공용 로직)
                case "/edu/list.do":
                case "/admin/edu/list.do":
                    PageObject pageObject = PageObject.getInstance(request);
                    String word = request.getParameter("word");
                    String category = request.getParameter("category");
                    
                    if(word != null && !word.isEmpty()) pageObject.setWord(word);
                    if(category != null && !category.isEmpty()) pageObject.setKey(category);
                    
                    // 목록 데이터 가져오기 (사용자/관리자 동일 서비스 사용)
                    request.setAttribute("list", Execute.execute(Init.getService("/edu/list.do"), pageObject));
                    request.setAttribute("pageObject", pageObject);
                    request.setAttribute("meta", dao.getMetaData()); 
                    
                    // URI에 admin이 포함되어 있으면 관리자 폴더의 jsp로 보냄
                    return (uri.indexOf("admin") != -1) ? "admin/edu/list" : "edu/list";

                // 2. 가이드 상세보기
                case "/edu/view.do":
                    long no = Long.parseLong(request.getParameter("no"));
                    request.setAttribute("vo", Execute.execute(Init.getService(uri), no));
                    return "edu/view";

                // 3. 가이드 등록 폼 및 처리
                case "/admin/edu/writeForm.do":
                    return "admin/edu/writeForm";

                case "/admin/edu/write.do":
                    EduVO writeVO = new EduVO();
                    writeVO.setTitle(request.getParameter("title"));
                    writeVO.setCategory(request.getParameter("category"));
                    writeVO.setWriter(request.getParameter("writer"));
                    writeVO.setSummary(request.getParameter("summary"));
                    writeVO.setContent(request.getParameter("content"));
                    writeVO.setTags(request.getParameter("tags"));
                    writeVO.setStatus(request.getParameter("status"));
                    
                    Execute.execute(Init.getService(uri), writeVO);
                    return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");

                // 4. 가이드 수정 폼 및 처리
                case "/admin/edu/updateForm.do":
                    long updateNo = Long.parseLong(request.getParameter("no"));
                    // 수정 폼을 채우기 위해 상세 정보를 가져옴
                    request.setAttribute("vo", Execute.execute(Init.getService("/edu/view.do"), updateNo));
                    return "admin/edu/updateForm";

                case "/admin/edu/update.do":
                    EduVO updateVO = new EduVO();
                    updateVO.setNo(Long.parseLong(request.getParameter("no")));
                    updateVO.setTitle(request.getParameter("title"));
                    updateVO.setCategory(request.getParameter("category"));
                    updateVO.setWriter(request.getParameter("writer"));
                    updateVO.setSummary(request.getParameter("summary"));
                    updateVO.setContent(request.getParameter("content"));
                    updateVO.setTags(request.getParameter("tags"));
                    updateVO.setStatus(request.getParameter("status"));
                    
                    Execute.execute(Init.getService(uri), updateVO);
                    // 수정 후 보던 상세 페이지로 이동
                    return "redirect:/edu/view.do?no=" + updateVO.getNo() + 
                           "&page=" + request.getParameter("page") + 
                           "&perPageNum=" + request.getParameter("perPageNum");

                // 5. 가이드 삭제
                case "/admin/edu/delete.do":
                    long deleteNo = Long.parseLong(request.getParameter("no"));
                    Execute.execute(Init.getService(uri), deleteNo);
                    return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");

                default: 
                    return "error/noPage";
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
            return "error/err_500"; 
        }
    }
}