package com.bsps2.disasterCategory.service;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.disasterCategory.dao.DisasterCategoryDAO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;
import com.bsps2.util.db.DB;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;

public class DisasterCategoryService implements Service {

    private DisasterCategoryDAO dao;

    @Override
    public void setDAO(DAO dao) {
        this.dao = (DisasterCategoryDAO) dao;
    }

    @Override
    public Object service(Object obj) throws Exception {
        if (obj instanceof Integer) {
            updateDisasterData((int) obj);
        }
        return dao.list();
    }

    public void updateDisasterData(int catID) throws Exception {
        Connection con = null;
        try {
            con = DB.getConnection();
            System.out.println(">>> [더미 테스트 모드] 데이터를 생성합니다 (catID: " + catID + ")");

            // [API 주석 처리] -------------------------------------------------
            /*
            String urlStr = ... (기존 API 호출 코드)
            XmlMapper xmlMapper = new XmlMapper();
            JsonNode root = xmlMapper.readTree(conn.getInputStream());
            JsonNode itemsNode = root.findValue("item");
            */
            // ---------------------------------------------------------------

            // [가상 더미 데이터 생성] Jackson 라이브러리를 이용해 가짜 JSON 생성
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            com.fasterxml.jackson.databind.node.ArrayNode dummyItems = mapper.createArrayNode();

            // 1. 폭설 + 도로 차단 (4번, 6번 중복 분류 테스트용)
            dummyItems.add(mapper.createObjectNode()
                .put("MSG_CN", "폭설로 인해 강원도 산간 도로가 전면 차단되었습니다. 우회바랍니다.")
                .put("DSSTR_RGN_NM", "강원도")
                .put("CREAT_DT", "202604111300")
                .put("SN", "DUMMY_01"));

            // 2. 지진 + 심각 (2번 카테고리 & 위험도 3단계 테스트용)
            dummyItems.add(mapper.createObjectNode()
                .put("MSG_CN", "[긴급] 경주 인근 규모 5.0 지진 발생. 심각 단계 발령, 대피하세요.")
                .put("DSSTR_RGN_NM", "경상북도 경주")
                .put("CREAT_DT", "202604111305")
                .put("SN", "DUMMY_02"));

            // 3. 미분류 데이터 (9번 카테고리 테스트용)
            dummyItems.add(mapper.createObjectNode()
                .put("MSG_CN", "분실물을 찾습니다. 검은색 가방을 보신 분은 연락 바랍니다.")
                .put("DSSTR_RGN_NM", "서울")
                .put("CREAT_DT", "202604111310")
                .put("SN", "DUMMY_03"));

            // 생성한 더미 데이터를 기존 로직의 itemsNode로 설정
            com.fasterxml.jackson.databind.JsonNode itemsNode = dummyItems;

            if (itemsNode != null) {
                for (JsonNode item : itemsNode) {
                    DisasterVO vo = new DisasterVO();
                    // 재난문자(10번) 규격에 맞춰 필드 추출
                    String content = item.path("MSG_CN").asText();
                    String location = item.path("DSSTR_RGN_NM").asText();
                    String date = item.path("CREAT_DT").asText();
                    String apiId = "MSG_" + item.path("SN").asText();

                    vo.setContent(content);
                    vo.setLocationName(location);
                    vo.setCreateDate(date);
                    vo.setApiId(apiId);

                    // --- 여기서부터는 기존 전처리 로직 그대로 유지 ---
                    List<Integer> catIDs = getCategoryList(vo.getLocationName(), vo.getContent());
                    
                    String fullText = vo.getLocationName() + " " + vo.getContent();
                    int level = (fullText.contains("심각") || fullText.contains("대피") || fullText.contains("규모")) ? 3 : 
                                (fullText.contains("주의") || fullText.contains("자제")) ? 2 : 1;
                    vo.setDangerLevel(level);

                    if (catIDs != null && !catIDs.isEmpty()) {
                        // DB 컬럼명 APIID 반영 필수!
                        if (dao.checkDuplicate(con, vo.getApiId()) == 0) {
                            dao.insertDisaster(con, vo, catIDs); 
                            System.out.println(">>> 더미 데이터 저장 성공: " + vo.getApiId());
                        }
                    }
                } 
            }
            System.out.println(">>> [테스트 완료] 더미 데이터 수집 로직이 끝났습니다.");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) con.close();
        }
    }// updateDisasterData()의 끝

    private List<Integer> getCategoryList(String location, String content) {
        List<Integer> catIDs = new ArrayList<>();
        String text = (location == null ? "" : location) + " " + (content == null ? "" : content);

        if (text.contains("화재") || text.contains("산불") || text.contains("폭발") || text.contains("발화") || text.contains("연기")) catIDs.add(1);
        if (text.contains("지진") || text.contains("해일") || text.contains("규모") || text.contains("진도")) catIDs.add(2);
        if (text.contains("태풍") || text.contains("호우") || text.contains("강풍") || text.contains("침수") || text.contains("범람")) catIDs.add(3);
        if (text.contains("폭염") || text.contains("한파") || text.contains("대설") || text.contains("적설") || text.contains("추위") || text.contains("더위") || text.contains("폭설")) catIDs.add(4);
        if (text.contains("산사태") || text.contains("붕괴") || text.contains("낙석")) catIDs.add(5);
        if (text.contains("교통") || text.contains("사고") || text.contains("통제") || text.contains("우회") || text.contains("정체") || text.contains("도로") || text.contains("차단")) catIDs.add(6);
        if (text.contains("감염병") || text.contains("미세먼지") || text.contains("황사") || text.contains("방역")) catIDs.add(7);
        if (text.contains("대피소") || text.contains("응급") || text.contains("구급") || text.contains("병원")) catIDs.add(8);

        if (catIDs.isEmpty()) catIDs.add(9);
        return catIDs;
    }
}