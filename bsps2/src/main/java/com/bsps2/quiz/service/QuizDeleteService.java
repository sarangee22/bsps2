package com.bsps2.quiz.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.quiz.dao.QuizDAO;
import com.bsps2.quiz.vo.QuizVO;

public class QuizDeleteService implements Service{

	private QuizDAO dao;
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (QuizDAO) dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.delete((Long)obj);
	}

}
