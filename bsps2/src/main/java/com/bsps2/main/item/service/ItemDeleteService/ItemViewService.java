package com.bsps2.main.item.service.ItemDeleteService;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO;
import com.bsps2.main.service.Service;

public class ItemViewService implements Service {
	private ItemDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (ItemDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// obj는 글번호(Long 또는 long)
		return dao.view((Long) obj);
	}
}
