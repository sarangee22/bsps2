package com.bsps2.disasterCategory.service;

import java.net.HttpURLConnection;
import java.net.URL;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import org.json.JSONArray;
import org.json.JSONObject;
import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.disasterCategory.dao.DisasterCategoryDAO;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.service.Service;

public class DisasterCategoryService implements Service {

	@Override
	public void setDAO(DAO dao) {
		this.dao = (DisasterCategoryDAO) dao;

	}// setDAO()의 끝

	@Override
	public Object service(Object obj) throws Exception {
		// [A] 페이지 요청 시마다 최신 API 데이터를 DB에 업데이트 (선택 사항)
		updateDisasterData();

		// [B] 업데이트가 끝난 후, 화면에 뿌려줄 카테고리 목록(8개)을 가져옴
		return dao.list();
	}// service의 끝

	private DisasterCategoryDAO dao;

	// 조립을 위한 Setter 메소드
	public void setDao(DisasterCategoryDAO dao) {
		this.dao = dao;
	}

	public void updateDisasterData() throws Exception {
	    // 1. API 호출 (행안부 재난문자 서비스 예시)
	    String serviceKey = "H81M3194303G9W7H";
	    String urlStr = "http://apis.data.go.kr/1741000/DisasterMsg3/getDisasterMsg1"
	                  + "?serviceKey=" + serviceKey + "&type=json&pageNo=1&numOfRows=50";

	    URL url = new URL(urlStr);
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    
	    // 데이터가 없을 경우 대비
	    try (BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))){
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) sb.append(line);
	        
	        String result = sb.toString();
	        
	        // JSON 응답이 정상적으로 왔을 때만 처리
	        if (result != null && result.trim().startsWith("{")) {
	            JSONObject obj = new JSONObject(result);
	            // 공공데이터 구조에 따른 접근
	            if(obj.has("DisasterMsg")) {
	                JSONArray rows = obj.getJSONArray("DisasterMsg").getJSONObject(1).getJSONArray("row");

	                for (int i = 0; i < rows.length(); i++) {
	                    JSONObject item = rows.getJSONObject(i);
	                    DisasterVO vo = new DisasterVO();
	                    
	                    vo.setApiId(item.getString("md101_sn"));
	                    // 분석을 위해 변수에 담아둡니다.
	                    String msg = item.getString("msg");
	                    vo.setContent(msg);
	                    
	                    // --- [추가 로직] 키워드분석을 통한 위험 등급(risk_grade) 설정 ---
	                    int level = 1; // 기본값: 정보/알림
	                    if (msg.contains("긴급") || msg.contains("대피") || msg.contains("심각") || msg.contains("경보")) {
	                        level = 3; // 심각
	                    } else if (msg.contains("주의") || msg.contains("자제") || msg.contains("제한")) {
	                        level = 2; // 주의
	                    }
	                    vo.setDangerLevel(level); // VO의 dangerLevel 필드에 저장
	                    // ---------------------------------------------------------

	                    vo.setCreateDate(item.getString("create_date"));
	                    vo.setLocationName(item.getString("location_name"));

	                    int catID = getCategoryByKeyword(vo.getContent());

	                    if (catID != 0) {
	                        if (dao.checkDuplicate(vo.getApiId()) == 0) {
	                            // 이제 vo 안에 dangerLevel(risk_grade)이 담긴 채로 넘어갑니다.
	                            dao.insert(vo, catID);
	                        }
	                    }
	                }
	            }
	        }
	        
	    } catch (Exception e) {
	        System.out.println("API 업데이트 중 오류 발생 (무시하고 목록 조회 진행): " + e.getMessage());
	    } // catch의 끝
	}
	// 키워드 분류 전용 메소드
	private int getCategoryByKeyword(String content) {
		if (content.contains("화재") || content.contains("산불"))
			return 1;
		if (content.contains("지진") || content.contains("해일"))
			return 2;
		if (content.contains("태풍") || content.contains("호우") || content.contains("폭풍"))
			return 3;
		if (content.contains("폭염") || content.contains("한파"))
			return 4;
		if (content.contains("산사태") || content.contains("붕괴"))
			return 5;
		if (content.contains("교통") || content.contains("사고"))
			return 6;
		if (content.contains("감염병") || content.contains("미세먼지"))
			return 7;
		if (content.contains("대피") || content.contains("응급"))
			return 8;
		return 0; // 미분류
	}// getCategoryByKeyword()의 끝

}// class()의 끝