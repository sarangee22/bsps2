package com.bsps2.qna.service;

import com.bsps2.qna.dao.QnaDAO;
import com.bsps2.qna.vo.QnaVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

//Main - QnaController - (QnaViewService) - QnaDAO // QnaVO
public class QnaViewService implements Service{

	private QnaDAO dao = null;
	
	public void setDAO(DAO dao) {
		this.dao = (QnaDAO) dao;
	}
	
	public QnaVO service(Object obj) throws Exception{
		Long[] arrs = (Long[]) obj;
		Long no = arrs[0];
		Long inc = arrs[1]; // 1-조회수 1증가 함. 0- 조회수 1증가 안함.
		if(inc == 1) {
			// 1. 조회수 1 증가
			// DB 처리 : list - List<VO>, view - VO, 외 update, delete, insert 문의 결과는 Integer
			Integer result = dao.increase(no);
			if(result != 1) throw new Exception("글보기 조회수 1증가 오류 : 글번호가 존재하지 않습니다.");
		}
		return dao.view(no);
	}
}
