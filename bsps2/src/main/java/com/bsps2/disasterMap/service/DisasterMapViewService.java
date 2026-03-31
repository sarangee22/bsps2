package com.bsps2.disasterMap.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.disasterMap.dao.DisasterMapDAO;

public class DisasterMapViewService implements Service {

    private DisasterMapDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (DisasterMapDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {

        Long disasterId = (Long) obj;

        return dao.view(disasterId);
    }
}