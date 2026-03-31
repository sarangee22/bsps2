package com.bsps2.main.item.service.ItemDeleteService;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO;
import com.bsps2.main.item.vo.ItemVO.ItemVO;
import com.bsps2.main.service.Service;

public class ItemViewService implements Service {
	private ItemDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (ItemDAO) dao;
	}

	@Override
	public ItemVO service(Object obj) throws Exception {
		// 넘겨받은 no(Long 타입)를 이용해 상세보기 실행
		return dao.view((Long) obj);
	}
} 