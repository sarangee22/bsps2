package com.bsps2.qna.service;

import com.bsps2.qna.dao.QnaDAO;
import com.bsps2.qna.vo.QnaVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

public class QnaUpdateService implements Service {

	private QnaDAO dao = null;
	
	// Init에서 이미 생성된 dao를 전달해서 저장해 놓는다. - 서버가 시작될 때 : 코딩 필
	public void setDAO(DAO dao) {
		this.dao = (QnaDAO) dao;
	}
	
	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.update((QnaVO) obj);
	}

}
