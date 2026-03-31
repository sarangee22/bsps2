package com.bsps2.member.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.member.dao.MemberDAO;
import com.bsps2.member.vo.LoginVO;

// Service 종류라고 하려면 반드시 Service를 상속 받아야만 한다.
public class LoginService implements Service{

	private MemberDAO dao = null;
	
	public void setDAO(DAO dao) {
		this.dao = (MemberDAO) dao;
	}

	@Override
	public LoginVO service(Object obj) throws Exception {
		// TODO Auto-generated method stub
		return dao.login((LoginVO) obj);
	}

}