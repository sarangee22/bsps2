package com.bsps2.disasterList.service;

import com.bsps2.main.service.Service;
import com.bsps2.util.page.PageObject;
import com.bsps2.main.dao.DAO;
import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.disasterList.dao.DisasterListDAO;

public class DisasterListService implements Service {

    private DisasterListDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (DisasterListDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        Object[] objs = (Object[]) obj;

        // 상세보기(view) : objs[0]이 Long 타입일 때
        if (objs[0] instanceof Long) {
            Long no = (Long) objs[0];
            return dao.view(no);
        } 
        // 리스트(list) : objs[0]이 Integer(catID), objs[1]이 PageObject일 때
        else {
            int catID = (Integer) objs[0];
            PageObject pageObject = (PageObject) objs[1];

            long totalRow = dao.getTotalRow(catID, pageObject);
            pageObject.setTotalRow(totalRow);

            return dao.list(catID, pageObject);
        }
    }
}