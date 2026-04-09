package com.bsps2.scrap.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.scrap.dao.ScrapDAO;

public class ScrapListService implements Service {

    private ScrapDAO dao;

    @Override
    public void setDAO(DAO dao) {
        // Init 클래스에서 주입해주는 DAO를 ScrapDAO로 캐스팅하여 저장
        this.dao = (ScrapDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        // 넘겨받은 데이터(아이디)를 사용하여 DAO의 list 메서드 호출
        // obj는 Controller에서 넘겨준 String 타입의 ID입니다.
        return dao.list((String) obj);
    }

}