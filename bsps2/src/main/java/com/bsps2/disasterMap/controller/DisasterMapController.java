package com.bsps2.disasterMap.controller;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import com.bsps2.disasterMap.ov.DisasterMapVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class DisasterMapController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {

        HttpSession session = request.getSession();

        try {
            String uri = request.getServletPath();
            System.out.println("DisasterMapController.execute().uri = " + uri);

            Object result = null;

            switch (uri) {

                // 1. 리스트
                case "/disasterMap/list.do":
                    PageObject pageObject = PageObject.getInstance(request);
                    request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
                    request.setAttribute("pageObject", pageObject);
                    return "disasterMap/list";

                // 2. 상세보기
                case "/disasterMap/view.do":
                    String strId = request.getParameter("disasterId");
                    if(strId == null || strId.trim().isEmpty()) return "redirect:list.do"; 
                    
                    // ✅ 파라미터를 Long으로 변환
                    Long viewId = Long.parseLong(strId);
                    request.setAttribute("vo", Execute.execute(Init.getService(uri), viewId));
                    return "disasterMap/view";

                // 3. 등록 폼
                case "/disasterMap/writeForm.do":
                    return "disasterMap/writeForm";

                // 4. 등록 처리
                case "/disasterMap/write.do":
                    DisasterMapVO wvo = new DisasterMapVO();
                    wvo.setDisasterName(request.getParameter("disasterName"));
                    wvo.setDisasterType(request.getParameter("disasterType"));
                    wvo.setRegion(request.getParameter("region"));
                    wvo.setAddress(request.getParameter("address"));
                    wvo.setContent(request.getParameter("content"));
                    
                    String wLat = request.getParameter("latitude");
                    String wLng = request.getParameter("longitude");
                    wvo.setLatitude((wLat != null && !wLat.isEmpty()) ? Double.parseDouble(wLat) : 0.0);
                    wvo.setLongitude((wLng != null && !wLng.isEmpty()) ? Double.parseDouble(wLng) : 0.0);

                    Execute.execute(Init.getService(uri), wvo);
                    session.setAttribute("msg", "새로운 재난 정보가 등록되었습니다.");
                    return "redirect:list.do";

                // 5. 수정 폼 (기존 데이터 불러오기)
                case "/disasterMap/updateForm.do":
                    String upIdStr = request.getParameter("disasterId");
                    if(upIdStr == null) return "redirect:list.do";
                    
                    // ✅ Long으로 변환
                    Long updateFormId = Long.parseLong(upIdStr);
                    request.setAttribute("vo", Execute.execute(Init.getService("/disasterMap/view.do"), updateFormId));
                    return "disasterMap/updateForm";

                // 6. 수정 처리
                case "/disasterMap/update.do":
                    DisasterMapVO uvo = new DisasterMapVO();
                    
                    // ✅ [수정 포인트] Integer.parseInt 대신 Long.parseLong 사용
                    String uIdStr = request.getParameter("disasterId");
                    if(uIdStr != null && !uIdStr.isEmpty()) {
                        // VO의 disasterId가 int라면 (int)Long.parseLong() 하거나 
                        // VO의 타입을 확인해서 맞춰야 합니다. 보통은 Long을 권장해요.
                        uvo.setDisasterId((int)Long.parseLong(uIdStr)); 
                    }
                    
                    uvo.setDisasterName(request.getParameter("disasterName"));
                    uvo.setDisasterType(request.getParameter("disasterType"));
                    uvo.setRegion(request.getParameter("region"));
                    uvo.setAddress(request.getParameter("address"));
                    uvo.setContent(request.getParameter("content"));
                    
                    String uLat = request.getParameter("latitude");
                    String uLng = request.getParameter("longitude");
                    uvo.setLatitude((uLat != null && !uLat.isEmpty()) ? Double.parseDouble(uLat) : 0.0);
                    uvo.setLongitude((uLng != null && !uLng.isEmpty()) ? Double.parseDouble(uLng) : 0.0);

                    // DB 수정 실행
                    result = Execute.execute(Init.getService(uri), uvo);

                    if(result != null && (Integer)result == 1) {
                        session.setAttribute("msg", "정보가 성공적으로 수정되었습니다.");
                    } else {
                        session.setAttribute("msg", "수정에 실패했습니다.");
                    }
                    
                    return "redirect:view.do?disasterId=" + uvo.getDisasterId();

                // 7. 삭제 처리
                case "/disasterMap/delete.do":
                    String delIdStr = request.getParameter("disasterId");
                    if(delIdStr != null) {
                        Long deleteId = Long.parseLong(delIdStr);
                        Execute.execute(Init.getService(uri), deleteId);
                        session.setAttribute("msg", "성공적으로 삭제되었습니다.");
                    }
                    return "redirect:list.do";

                default:
                    return "error/noPage";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("exception", e);
            return "error/err_500";
        }
    }
}