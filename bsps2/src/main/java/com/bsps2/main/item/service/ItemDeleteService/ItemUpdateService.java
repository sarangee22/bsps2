package com.bsps2.main.item.service.ItemDeleteService;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO;
import com.bsps2.main.item.vo.ItemVO.ItemVO;
import com.bsps2.main.service.Service;

public class ItemUpdateService implements Service {
	private ItemDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (ItemDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// obj는 수정할 데이터가 담긴 ItemVO
		return dao.update((ItemVO) obj);
	}
}
