package com.bsps2.quiz.service;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.quiz.dao.QuizDAO;

public class QuizListService implements Service {

    private QuizDAO dao;
    
    // 조립 시 실행됨
    @Override
    public void setDAO(DAO dao) {
        this.dao = (QuizDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {

        return dao.list();
    }
}