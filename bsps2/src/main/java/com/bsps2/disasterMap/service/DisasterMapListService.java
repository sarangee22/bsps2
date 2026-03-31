package com.bsps2.disasterMap.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.disasterMap.dao.DisasterMapDAO;
import com.bsps2.util.page.PageObject;

public class DisasterMapListService implements Service {

    private DisasterMapDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (DisasterMapDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {

        PageObject pageObject = (PageObject) obj;

        pageObject.setTotalRow(dao.getTotalRow(pageObject));

        return dao.list(pageObject);
    }
}