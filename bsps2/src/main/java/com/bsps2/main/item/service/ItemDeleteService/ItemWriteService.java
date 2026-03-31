package com.bsps2.main.item.service.ItemDeleteService;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.dao.ItemDAO.ItemDAO;
import com.bsps2.main.item.vo.ItemVO.ItemVO;
import com.bsps2.main.service.Service;

public class ItemWriteService implements Service {
	private ItemDAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = (ItemDAO) dao;
	}

	@Override
	public Integer service(Object obj) throws Exception {
		// 넘겨받은 ItemVO 객체를 그대로 DAO의 write로 전달
		return dao.write((ItemVO) obj);
	}
} 