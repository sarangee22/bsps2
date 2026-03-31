package com.bsps2.disasterSafe.service;

import java.util.List;
import com.bsps2.disasterSafe.dao.AgencyDAO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.util.page.PageObject;

public class AgencyListService implements Service {

	private AgencyDAO dao;
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (AgencyDAO) dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		PageObject pageObject = (PageObject) obj;


		pageObject.setTotalRow(dao.getTotalRow(pageObject));


		return dao.list(pageObject);
	}

    
}