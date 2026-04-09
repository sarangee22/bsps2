package com.bsps2.member.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.member.dao.MemberDAO;
import com.bsps2.member.vo.LoginVO;

public class LoginService implements Service {

    private MemberDAO dao = null;
    
    public void setDAO(DAO dao) {
        this.dao = (MemberDAO) dao;
    }

    @Override
    public LoginVO service(Object obj) throws Exception {
        // 1. 로그인 시도
        LoginVO vo = dao.login((LoginVO) obj);
        
        // 2. 로그인 성공 시 최근 접속일 업데이트 (에러 방지를 위해 if문 사용)
        if(vo != null) {
            dao.updateConDate(vo.getId());
        }
        
        return vo;
    }
}