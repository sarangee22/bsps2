package com.bsps2.main.edu.service.EduService;

import java.util.List;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.edu.dao.EduDAO.EduDAO;
import com.bsps2.main.edu.vo.EduVO.EduVO;
import com.bsps2.main.service.Service;
import com.bsps2.util.page.PageObject;

public class EduListService implements Service {
    private EduDAO dao;
    @Override
    public void setDAO(DAO dao) { this.dao = (EduDAO) dao; }

    @Override
    public Object service(Object obj) throws Exception {
        PageObject pageObject = (PageObject) obj;
        pageObject.setTotalRow(dao.getTotalRow(pageObject));
        return dao.list(pageObject);
    }
}