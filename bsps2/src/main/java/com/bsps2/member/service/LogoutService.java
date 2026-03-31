package com.bsps2.member.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

public class LogoutService implements Service {
    public void setDAO(DAO dao) {}

    public Object service(Object obj) throws Exception {
        return null; // 세션 삭제는 Controller에서!
    }
}