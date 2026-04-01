package com.bsps2.disasterCategory.service;

import java.sql.Connection;
import java.util.List;
import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.disasterCategory.dao.DisasterCategoryDAO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.util.db.DB;

public class DisasterCategoryService implements Service {

    private DisasterCategoryDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (DisasterCategoryDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        // [1] 데이터 전처리 실행
        updateDisasterData();

        // [2] 카테고리 목록 반환
        return dao.list();
    }

    public void updateDisasterData() throws Exception {
        Connection con = null;
        try {
            // 💡 핵심: 커넥션을 여기서 딱 한 번만 연결합니다.
            con = DB.getConnection();
            System.out.println(">>> [임시] 로컬 DB 전처리를 시작합니다 (커넥션 공유 모드)");

            // 1. 원본 데이터 읽기 (con 전달)
            List<DisasterVO> rawList = dao.getRawDisasterData(con);
            System.out.println(">>> 전처리 대상 원본 데이터: " + rawList.size() + "건");

            for (DisasterVO vo : rawList) {
                int catID = getCategoryByKeyword(vo.getContent());
                
                int level = 1;
                if (vo.getContent().contains("심각") || vo.getContent().contains("대피") || vo.getContent().contains("경보")) {
                    level = 3;
                } else if (vo.getContent().contains("주의") || vo.getContent().contains("자제")) {
                    level = 2;
                }
                vo.setDangerLevel(level);

                if (catID != 0) {
                    // 💡 핵심: 중복 체크와 저장에 동일한 con을 사용합니다.
                    if (dao.checkDuplicate(con, vo.getApiId()) == 0) {
                        dao.insertAll(con, vo, catID); 
                    }
                }
            }
            System.out.println(">>> [완료] 로컬 데이터 전처리가 끝났습니다.");

        } catch (Exception e) {
            System.out.println(">>> 전처리 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // 💡 여기서 마지막에 한 번만 닫아줍니다. (ORA-12519 방지)
            if (con != null) con.close();
        }
    }

    private int getCategoryByKeyword(String content) {
        if (content == null) return 0;
        if (content.contains("화재") || content.contains("산불") || content.contains("폭발") || content.contains("연기")) return 1;
        if (content.contains("지진") || content.contains("해일") || content.contains("진동")) return 2;
        if (content.contains("태풍") || content.contains("호우") || content.contains("강풍") || content.contains("풍랑") || content.contains("침수") || content.contains("비 ")) return 3;
        if (content.contains("폭염") || content.contains("한파") || content.contains("대설") || content.contains("눈 ") || content.contains("더위")) return 4;
        if (content.contains("산사태") || content.contains("붕괴") || content.contains("낙석")) return 5;
        if (content.contains("교통") || content.contains("사고") || content.contains("통제") || content.contains("우회")) return 6;
        if (content.contains("감염병") || content.contains("미세먼지") || content.contains("황사") || content.contains("코로나")) return 7;
        return 8; 
    }
}