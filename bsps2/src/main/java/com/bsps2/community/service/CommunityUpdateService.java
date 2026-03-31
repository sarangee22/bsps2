package com.bsps2.community.service;

import com.bsps2.community.dao.CommunityDAO;
import com.bsps2.community.vo.CommunityVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

public class CommunityUpdateService implements Service {

	private CommunityDAO dao;
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (CommunityDAO) dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.update((CommunityVO)obj);
	}

}
