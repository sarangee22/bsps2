package com.bsps2.qna.service;

import java.util.List;

import com.bsps2.qna.dao.QnaDAO;
import com.bsps2.qna.vo.QnaVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

//Main - QnaController - (QnaListService) - QnaDAO // QnaVO
public class QnaListService implements Service{

	private QnaDAO dao = null;
	

	public void setDAO(DAO dao) {
		this.dao = (QnaDAO) dao;
	}
	
	public List<QnaVO> service(Object obj) throws Exception{
		return dao.list((String)obj);
	}
}
