package com.bsps2.main.controller;


import jakarta.servlet.http.HttpServletRequest;

public class MainController implements Controller{

	@Override
	public String execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return "main/main";
	}

}
