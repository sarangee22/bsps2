package com.bsps2.scrap.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.scrap.dao.ScrapDAO;
import com.bsps2.scrap.vo.ScrapVO;

public class ScrapService implements Service {

    private ScrapDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (ScrapDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        // [로그] 저장되는 데이터 확인
        System.out.println("ScrapService.service() - 스크랩 저장 중: " + obj);
        
        // Controller에서 넘어온 ScrapVO를 사용하여 DAO의 scrap 메서드 호출
        return dao.scrap((ScrapVO) obj);
    }
}