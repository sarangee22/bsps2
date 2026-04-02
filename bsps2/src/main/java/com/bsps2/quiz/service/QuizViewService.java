package com.bsps2.quiz.service;

import java.util.HashMap;
import java.util.Map;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.quiz.dao.QuizDAO;

public class QuizViewService implements Service{

	private QuizDAO dao;

	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (QuizDAO) dao;

		
	}

	@Override
	public Object service(Object obj) throws Exception {
		// 1. 넘겨받은 데이터 [no, inc] 배열로 캐스팅
	    Long[] objs = (Long[]) obj; 
	    Long no = objs[0];
	    Long inc = objs[1];

	    System.out.println("QuizViewService.service() - no: " + no + ", inc: " + inc);

	    // 2. inc가 1일 때만 조회수 증가 (요구사항 5-2) [cite: 1]
	    if (inc == 1) {
	        dao.increase(no);
	    }
	    
	    // 3. Map에 문제 정보와 해설 정보를 따로 담음
	    Map<String, Object> map = new HashMap<>();
	    map.put("vo", dao.view(no));          // 문제 정보 (QuizVO) [cite: 4]
	    map.put("explain", dao.getReply(no)); // 해당 문제의 해설 내용 (String) 
	    
	    return map;
	
	}

}
