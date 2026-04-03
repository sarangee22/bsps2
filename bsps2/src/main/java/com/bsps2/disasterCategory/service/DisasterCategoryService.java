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

        // 1. 화재 (건축물, 임야, 폭발 등)
        if (content.contains("화재") || content.contains("불나") || content.contains("산불") || 
            content.contains("폭발") || content.contains("연기") || content.contains("발화")) return 1;

        // 2. 지진/해일 (진도, 여진, 해수면 등)
        if (content.contains("지진") || content.contains("해일") || content.contains("진동") || 
            content.contains("진도") || content.contains("여진") || content.contains("흔들")) return 2;

        // 3. 태풍/호우 (기상특보 및 물 관련 피해)
        if (content.contains("태풍") || content.contains("호우") || content.contains("강풍") || 
            content.contains("풍랑") || content.contains("침수") || content.contains("범람") || 
            content.contains("비 ") || content.contains("강수") || content.contains("주의보") || content.contains("경보")) return 3;

        // 4. 폭염/한파 (기온 및 적설 관련)
        if (content.contains("폭염") || content.contains("한파") || content.contains("대설") || 
            content.contains("눈 ") || content.contains("적설") || content.contains("더위") || content.contains("추위")) return 4;

        // 5. 산사태/붕괴 (지반 및 시설물 파손)
        if (content.contains("산사태") || content.contains("붕괴") || content.contains("낙석") || 
            content.contains("균열") || content.contains("침하")) return 5;

        // 6. 교통/산업사고 (도로 통제 및 유해물질)
        if (content.contains("교통") || content.contains("사고") || content.contains("통제") || 
            content.contains("우회") || content.contains("정체") || content.contains("유출") || content.contains("가스")) return 6;

        // 7. 감염병/환경 (질병 및 대기질)
        if (content.contains("감염병") || content.contains("미세먼지") || content.contains("황사") || 
            content.contains("코로나") || content.contains("방역") || content.contains("확진")) return 7;

        // 8. 응급처치/대피소 (구호 및 의료 지원)
        if (content.contains("대피소") || content.contains("응급") || content.contains("구급") || 
            content.contains("의료") || content.contains("심폐") || content.contains("병원") || content.contains("소생")) return 8;

        // 9. 기타 (위의 키워드에 걸리지 않는 모든 데이터)
        return 9; 
    }}