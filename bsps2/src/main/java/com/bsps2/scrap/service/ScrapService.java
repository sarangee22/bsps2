package com.bsps2.scrap.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.scrap.dao.ScrapDAO;
import com.bsps2.scrap.vo.ScrapVO;

public class ScrapService implements Service {

    private ScrapDAO dao;

    // Init에서 조립할 때 사용될 setter
    public void setDAO(Object dao) {
        this.dao = (ScrapDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        // [로그] 어떤 데이터가 넘어오는지 확인
        System.out.println("ScrapService.service() - obj : " + obj);
        
        // 현재 실행 중인 URI에 따라 분기 처리가 필요합니다.
        // (보통 AuthorityFilter나 DispatcherServlet에서 uri를 어딘가에 담아둡니다. 
        // 만약 obj에 uri를 같이 보낸다면 그에 맞춰 수정 가능합니다.)
        
        // 1. 스크랩 리스트 보기 (obj가 String id인 경우)
        if (obj instanceof String) {
            return dao.list((String) obj);
        }
        
        // 2. 스크랩 저장 (obj가 ScrapVO인 경우)
        else if (obj instanceof ScrapVO) {
            return dao.scrap((ScrapVO) obj);
        }
        
        // 3. 스크랩 취소/삭제 (obj가 Long scrapNo인 경우)
        else if (obj instanceof Long) {
            return dao.delete((Long) obj);
        }

        return null;
    }

	@Override
	public void setDAO(DAO dao) {
		// 1. 넘겨받은 공통 DAO 객체를 ScrapDAO 타입으로 형변환하여 저장합니다.
	    this.dao = (ScrapDAO) dao;
	}
}