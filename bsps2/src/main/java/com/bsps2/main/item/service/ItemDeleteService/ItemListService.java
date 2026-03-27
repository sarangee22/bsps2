package com.bsps2.main.item.service.ItemDeleteService;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO;
import com.bsps2.main.service.Service;
import com.bsps2.util.page.PageObject;

public class ItemListService implements Service {
	private ItemDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (ItemDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		PageObject pageObject = (PageObject) obj;
		// 1. 전체 데이터 개수 구하기 - 페이지 처리를 위해 필요
		pageObject.setTotalRow(dao.getTotalRow(pageObject));
		// 2. 리스트 데이터 가져오기 및 반환
		return dao.list(pageObject);
	}
}