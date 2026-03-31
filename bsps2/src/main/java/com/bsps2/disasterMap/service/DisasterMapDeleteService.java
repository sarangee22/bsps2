package com.bsps2.disasterMap.service;

import com.bsps2.disasterMap.dao.DisasterMapDAO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

public class DisasterMapDeleteService implements Service {

	private DAO dao;

	@Override
	public void setDAO(DAO dao) {
		this.dao = dao;
	}

	@Override
	public Object service(Object obj) throws Exception {

		Long disasterId = (Long) obj;

		return ((DisasterMapDAO) dao).delete(disasterId);
	}
}