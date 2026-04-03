package com.bsps2.disasterCategory.service;

import java.sql.Connection;
import java.util.ArrayList;
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
            // 커넥션을 여기서 딱 한 번만 연결합니다.
            con = DB.getConnection();
            System.out.println(">>> [임시] 로컬 DB 전처리를 시작합니다 (커넥션 공유 모드)");

            // 1. 원본 데이터 읽기 (con 전달)
            List<DisasterVO> rawList = dao.getRawDisasterData(con);
            System.out.println(">>> 전처리 대상 원본 데이터: " + rawList.size() + "건");

            for (DisasterVO vo : rawList) {
                // 단일 int가 아니라 List를 받습니다.
                List<Integer> catIDs = getCategoryList(vo.getLocationName(), vo.getContent());
                
                // 위험 등급 설정 로직 (기존과 동일)
                String fullText = vo.getLocationName() + " " + vo.getContent();
                int level = (fullText.contains("심각") || fullText.contains("대피") || fullText.contains("경보") || fullText.contains("규모")) ? 3 : 
                            (fullText.contains("주의") || fullText.contains("자제")) ? 2 : 1;
                vo.setDangerLevel(level);

                // 리스트가 비어있지 않을 때만 저장 로직 실행
                if (catIDs != null && !catIDs.isEmpty()) {
                    if (dao.checkDuplicate(con, vo.getApiId()) == 0) {
                        // DAO의 수정된 insertAll(con, vo, List) 호출
                        dao.insertAll(con, vo, catIDs); 
                    }
                }
            }
            System.out.println(">>> [완료] 로컬 데이터 전처리가 끝났습니다.");

        } catch (Exception e) {
            System.out.println(">>> 전처리 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // 마지막에 한 번만 닫아줍니다. (ORA-12519 방지)
            if (con != null) con.close();
        }
    }

    private List<Integer> getCategoryList(String location, String content) {
        List<Integer> catIDs = new ArrayList<>();
        
        // 안전한 검사를 위해 null 처리 및 텍스트 결합
        String loc = (location == null) ? "" : location;
        String con = (content == null) ? "" : content;
        String text = loc + " " + con;

        // 1. 화재
        if (text.contains("화재") || text.contains("산불") || text.contains("폭발") || text.contains("발화")) catIDs.add(1);
        
        // 2. 지진/해일
        if (text.contains("지진") || text.contains("해일") || text.contains("규모") || text.contains("진도")) catIDs.add(2);
        
        // 3. 태풍/호우
        if (text.contains("태풍") || text.contains("호우") || text.contains("강풍") || text.contains("침수") || text.contains("범람")) catIDs.add(3);
        
        // 4. 폭염/한파 (대설 포함)
        if (text.contains("폭염") || text.contains("한파") || text.contains("대설") || text.contains("적설") || text.contains("추위") || text.contains("더위")) catIDs.add(4);
        
        // 5. 산사태/붕괴
        if (text.contains("산사태") || text.contains("붕괴") || text.contains("낙석")) catIDs.add(5);
        
        // 6. 교통/산업사고 (사용자님이 원하신 대로 통제 정보 등 포함)
        if (text.contains("교통") || text.contains("사고") || text.contains("통제") || text.contains("우회") || text.contains("정체")) catIDs.add(6);
        
        // 7. 감염병/환경
        if (text.contains("감염병") || text.contains("미세먼지") || text.contains("황사") || text.contains("방역")) catIDs.add(7);
        
        // 8. 응급/대피
        if (text.contains("대피소") || text.contains("응급") || text.contains("구급") || text.contains("병원")) catIDs.add(8);

        // 💡 어떤 조건에도 걸리지 않았다면 9번(기타)으로 분류
        if (catIDs.isEmpty()) {
            catIDs.add(9);
        }

        return catIDs;
    }
}