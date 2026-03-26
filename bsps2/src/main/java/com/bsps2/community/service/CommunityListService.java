package com.bsps2.community.service;

import com.bsps2.community.dao.CommunityDAO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.util.page.PageObject;

public class CommunityListService implements Service {

	private CommunityDAO dao;
	
	@Override
	public void setDAO(DAO dao) {
		this.dao= (CommunityDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		
		//1.전달 받은 obj를 PageObject로 캐스팅
		PageObject pageObject = (PageObject)obj;
		//2. 전체 데이터 개수 가져와서 PageObject에 세팅 (페이징)
		pageObject.setTotalRow(dao.getTotalRow(pageObject));
		
		return dao.list(pageObject);
	}

}
