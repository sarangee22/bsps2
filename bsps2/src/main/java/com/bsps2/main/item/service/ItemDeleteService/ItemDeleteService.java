package com.bsps2.main.item.service.ItemDeleteService;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO;
import com.bsps2.main.service.Service;

public class ItemDeleteService implements Service {
	private ItemDAO dao;

	@Override 
	public void setDAO(DAO dao) {
		this.dao = (ItemDAO) dao;
	}

	@Override
	public Integer service(Object obj) throws Exception {
		// 넘겨받은 no(Long 타입)를 이용해 삭제 실행
		return dao.delete((Long) obj);
	}
}