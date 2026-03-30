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
	public Integer service(Object obj) throws Exception {
		// 수정된 데이터가 담긴 ItemVO 객체 전달
		return dao.update((ItemVO) obj);
	}
}