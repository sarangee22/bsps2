package com.bsps2.main.edu.service.EduService;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.edu.dao.EduDAO.EduDAO;
import com.bsps2.main.service.Service;

public class EduViewService implements Service {
    private EduDAO dao;
    @Override
    public void setDAO(DAO dao) { this.dao = (EduDAO) dao; }

    @Override
    public Object service(Object obj) throws Exception {
        return dao.view((Long) obj);
    }
}