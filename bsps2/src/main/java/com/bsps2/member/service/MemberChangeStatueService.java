package com.bsps2.member.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.member.dao.MemberDAO;
import com.bsps2.member.vo.MemberVO;

public class MemberChangeStatueService implements Service {

	private MemberDAO dao = null;
	
	public void setDAO(DAO dao) {
		this.dao = (MemberDAO) dao;
	}

	@Override
	public Object service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.changeStatus((MemberVO) obj);
	}

}
