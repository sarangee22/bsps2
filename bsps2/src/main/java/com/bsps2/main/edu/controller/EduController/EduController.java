package com.bsps2.main.edu.controller.EduController;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.edu.dao.EduDAO.EduDAO;
import com.bsps2.main.edu.vo.EduVO.EduVO;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.bsps2.member.vo.LoginVO; 

public class EduController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        try {
            String uri = request.getServletPath();
            EduDAO dao = new EduDAO(); 
            HttpSession session = request.getSession();
            LoginVO login = (LoginVO) session.getAttribute("login");
            
            // 리스트(.list)와 상세보기(.view)를 제외한 모든 요청은 관리자 권한 체크
            if (!(uri.contains("list.do") || uri.contains("view.do"))) {
                if (login == null || !login.getGradeName().equals("관리자")) {
                    session.setAttribute("msg", "관리자 권한이 필요합니다.");
                    // 권한 없으면 리스트로 튕겨버림
                    return "redirect:list.do";
                }
            }

            switch (uri) {
                case "/edu/list.do":
                case "/admin/edu/list.do":
                    PageObject pageObject = PageObject.getInstance(request);
                    String word = request.getParameter("word");
                    String category = request.getParameter("category");
                    
                    if(word != null && !word.isEmpty()) pageObject.setWord(word);
                    if(category != null && !category.isEmpty()) pageObject.setKey(category);
                    
                    request.setAttribute("list", Execute.execute(Init.getService("/edu/list.do"), pageObject));
                    request.setAttribute("pageObject", pageObject);
                    request.setAttribute("meta", dao.getMetaData()); 
                    
                    return (uri.indexOf("admin") != -1) ? "admin/edu/list" : "edu/list";

                case "/edu/view.do":
                    long no = Long.parseLong(request.getParameter("no"));
                    request.setAttribute("vo", Execute.execute(Init.getService(uri), no));
                    return "edu/view";

                case "/edu/writeForm.do":
                    return "edu/writeForm";

                case "/edu/write.do":
                    EduVO writeVO = new EduVO();
                    writeVO.setTitle(request.getParameter("title"));
                    writeVO.setCategory(request.getParameter("category"));
                    writeVO.setWriter(request.getParameter("writer"));
                    writeVO.setSummary(request.getParameter("summary"));
                    writeVO.setContent(request.getParameter("content"));
                    writeVO.setTags(request.getParameter("tags"));
                    writeVO.setStatus(request.getParameter("status"));
                    
                    Execute.execute(Init.getService(uri), writeVO);
                    session.setAttribute("msg", "성공적으로 등록되었습니다.");
                    return "redirect:list.do";

                case "/edu/updateForm.do":
                    long updateNo = Long.parseLong(request.getParameter("no"));
                    request.setAttribute("vo", Execute.execute(Init.getService("/edu/view.do"), updateNo));
                    return "edu/updateForm";

                case "/edu/update.do":
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
                    session.setAttribute("msg", "성공적으로 수정되었습니다.");
                    return "redirect:view.do?no=" + updateVO.getNo() + 
                           "&page=" + request.getParameter("page") + 
                           "&perPageNum=" + request.getParameter("perPageNum");

                case "/edu/delete.do":
                    long deleteNo = Long.parseLong(request.getParameter("no"));
                    Execute.execute(Init.getService(uri), deleteNo);
                    session.setAttribute("msg", "삭제되었습니다.");
                    return "redirect:list.do";

                default: 
                    return "error/noPage";
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
            return "error/err_500"; 
        }
    }
}