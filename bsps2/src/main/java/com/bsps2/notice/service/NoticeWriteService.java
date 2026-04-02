package com.bsps2.notice.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.notice.dao.NoticeDAO;
import com.bsps2.notice.vo.NoticeVO;

public class NoticeWriteService implements Service{

	private NoticeDAO dao = null;
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (NoticeDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.write((NoticeVO) obj);
	}

}
