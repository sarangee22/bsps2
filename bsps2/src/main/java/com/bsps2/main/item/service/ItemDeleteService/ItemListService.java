package com.bsps2.main.item.service.ItemDeleteService; // 1. 패키지 경로 확인

import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO;
import com.bsps2.main.item.vo.ItemVO.ItemVO;
import com.bsps2.main.service.Service;
import com.bsps2.util.page.PageObject;

public class ItemListService implements Service {

    private ItemDAO dao;

    // Init에서 이미 생성된 dao를 전달받아 저장한다.
    @Override
    public void setDAO(DAO dao) {
        this.dao = (ItemDAO) dao;
    }

    @Override
    public List<ItemVO> service(Object obj) throws Exception {
        // 컨트롤러에서 넘겨받은 PageObject로 형변환
        PageObject pageObject = (PageObject) obj;
        
        // [중요] ItemDAO에 getTotalRow(pageObject) 메서드가 반드시 있어야 합니다.
        // 전체 데이터 개수를 가져와서 세팅해야 페이징 계산이 완료됩니다.
        pageObject.setTotalRow(dao.getTotalRow(pageObject));
        
        // 실제 리스트 데이터를 가져와 리턴
        return dao.list(pageObject);
    }
}