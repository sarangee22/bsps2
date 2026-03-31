package com.bsps2.qna.service;

import com.bsps2.qna.dao.QnaDAO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

public class QnaDeleteService implements Service {

	private QnaDAO dao = null;
	

	public void setDAO(DAO dao) {
		this.dao = (QnaDAO) dao;
	}
	
	@Override
	public Integer service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.delete((Long) obj);
	}

}
