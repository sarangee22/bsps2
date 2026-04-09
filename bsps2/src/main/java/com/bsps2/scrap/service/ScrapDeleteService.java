package com.bsps2.scrap.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.scrap.dao.ScrapDAO;

public class ScrapDeleteService implements Service {

    private ScrapDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (ScrapDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        // 넘겨받은 obj(scrapNo)를 캐스팅하여 DAO의 delete 메서드 호출
        return dao.delete((Long) obj);
    }

}