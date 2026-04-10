package com.bsps2.disasterCategory.controller;

import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.page.PageObject;
import jakarta.servlet.http.HttpServletRequest;

public class DisasterCategoryController implements Controller {

    @Override
    public String execute(HttpServletRequest request) {
        request.setAttribute("url", request.getRequestURL());
        try {
            String uri = request.getServletPath();

            switch (uri) {
                case "/disasterCategory/list.do":
                    PageObject pageObject = PageObject.getInstance(request);
                    
                    // 1. 먼저 API 데이터를 수집하도록 서비스에 Integer(catID)를 던집니다.
                    // 10번(재난문자)을 호출하면 자동으로 분류해서 DB에 저장됩니다.
                    Execute.execute(Init.getService(uri), 10); 
                    
                    // 2. 그 후 DB에 저장된 카테고리 목록을 가져와서 request에 담습니다.
                    request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
                    
                    System.out.println("DisasterCategoryController.execute().pageObject - " + pageObject);
                    request.setAttribute("pageObject", pageObject);
                    
                    return "/disasterCategory/list";

                default:
                    return "error/noPage";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("moduleName", "재난 카테고리");
            request.setAttribute("e", e);
            return "error/err_500";
        }
    }
}