package com.bsps2.member.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.member.dao.MemberDAO;
import com.bsps2.util.page.PageObject;

public class MemberListService implements Service {
    private MemberDAO dao = null;

    // Init에서 MemberDAO를 주입받기 위한 메서드
    public void setDAO(DAO dao) {
        this.dao = (MemberDAO) dao;
    }

    // 실제 비즈니스 로직 실행 (회원 목록 가져오기)
    public Object service(Object obj) throws Exception {
        // 회원 목록은 입력 파라미터(obj)가 필요 없으므로 null이 전달되어도 무방합니다..
    	return dao.list((PageObject) obj);
    }
}