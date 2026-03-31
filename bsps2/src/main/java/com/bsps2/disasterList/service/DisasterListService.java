package com.bsps2.disasterList.service;

import com.bsps2.main.service.Service;
import com.bsps2.util.page.PageObject;
import com.bsps2.main.dao.DAO;
import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.disasterList.dao.DisasterListDAO;

public class DisasterListService implements Service {

    private DisasterListDAO dao;

    @Override
    public void setDAO(DAO dao) {
        // [수정] 부모 타입인 DAO를 자식 타입인 DisasterListDAO로 형변환해야 합니다.
        this.dao = (DisasterListDAO) dao;
        
    } //setDAO()의 끝

    @Override
    public Object service(Object obj) throws Exception {
        // [로그] 넘어온 데이터 확인용 (디버깅)
        System.out.println("DisasterListService.service() - obj : " + obj);

        // 실행되는 URI를 확인하여 list와 view 로직을 분기합니다.
        // Init.java에서 현재 실행 중인 URI 정보를 서비스에 전달하는 구조여야 합니다.
        // 만약 서비스 내에서 uri 확인이 어렵다면 obj의 구성을 체크하여 분기합니다.
        
        Object[] objs = (Object[]) obj;

        // 데이터 분석: 0번째 데이터가 Long이면 상세보기(view), Integer면 리스트(list)
        // (또는 objs[1]이 PageObject인지 Long인지로 구분 가능)
        if (objs[0] instanceof Long) {
            // --- [상세보기(view.do) 처리 로직] ---
            // objs[0] : no (Long), objs[1] : inc (Long)
            Long no = (Long) objs[0];
            // 상세보기는 페이징 처리가 필요 없으므로 바로 DAO 호출
            return dao.view(no);
            
        } else {
            // --- [리스트(list.do) 처리 로직] ---
            // objs[0] : catID (int 또는 Integer), objs[1] : pageObject (PageObject)
            int catID = (int) objs[0];
            PageObject pageObject = (PageObject) objs[1];

            // 1. 전체 데이터 개수 구하기
            long totalRow = dao.getTotalRow(catID, pageObject);
            
            // 2. PageObject 세팅 (startRow, endRow 자동 계산)
            pageObject.setTotalRow(totalRow);
            
            // [로그] 확인용
            System.out.println("DisasterListService.service() - totalRow : " + totalRow);

            // 3. DAO의 list 메소드 호출
            return dao.list(catID, pageObject);
        }
        
    }// service()의 끝
    
    public DisasterVO view(long no) throws Exception {
        // DAO의 view 메서드 호출
        return dao.view(no);
    } // view()의 끝
    
} //클래스의 끝