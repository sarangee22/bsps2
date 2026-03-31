package com.bsps2.disasterSafe.service;

import com.bsps2.disasterSafe.dao.AgencyDAO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

public class AgencyDeleteService implements Service {
	
	private AgencyDAO dao;

	
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (AgencyDAO) dao;

	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		int id = (int) obj;
		
		return dao.delete(id);
	}

}
