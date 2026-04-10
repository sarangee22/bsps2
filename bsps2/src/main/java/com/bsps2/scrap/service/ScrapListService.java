package com.bsps2.scrap.service;

import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.scrap.dao.ScrapDAO;
import com.bsps2.scrap.vo.ScrapVO;
import com.bsps2.util.page.PageObject;

public class ScrapListService implements Service {

    private ScrapDAO dao;

    @Override
    public void setDAO(DAO dao) {
        // Init 클래스에서 주입해주는 DAO를 ScrapDAO로 캐스팅하여 저장
        this.dao = (ScrapDAO) dao;
    }

    @Override
    public List<ScrapVO> service(Object obj) throws Exception {
        // [수정] 컨트롤러에서 넘어온 데이터가 Object[] 배열인 것을 활용
        Object[] objs = (Object[]) obj;
        String id = (String) objs[0];
        PageObject pageObject = (PageObject) objs[1];
        
        // DAO 호출 시 파라미터 2개 전달
        return dao.list(id, pageObject);
    }

}