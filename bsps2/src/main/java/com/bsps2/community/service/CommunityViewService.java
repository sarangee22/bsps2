package com.bsps2.community.service;

import com.bsps2.community.dao.CommunityDAO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

public class CommunityViewService implements Service{

	private CommunityDAO dao;
	
	@Override
	public void setDAO(DAO dao) {
		// TODO Auto-generated method stub
		this.dao = (CommunityDAO) dao;
		
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		//1. 전달받은 obj를 Long[] 배열로 형변환
		Long[] objs = (Long[]) obj;
		Long no = objs[0];
		Long inc = objs[1];
		
		//2.조회수 증가 처리
		if(inc == 1) {
			dao.increase(no);
		}
		
		//3. 상세 데이터(vo)를 가져와서 반환
		return dao.view(no);
	}

}
