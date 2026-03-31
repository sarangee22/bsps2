package com.bsps2.disasterMap.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.disasterMap.dao.DisasterMapDAO;
import com.bsps2.disasterMap.ov.DisasterMapVO;


public class DisasterMapWriteService implements Service {

    private DisasterMapDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (DisasterMapDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {

        DisasterMapVO vo = (DisasterMapVO) obj;

        return dao.write(vo);
    }
}