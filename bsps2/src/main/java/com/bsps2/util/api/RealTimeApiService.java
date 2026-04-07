package com.bsps2.util.api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class RealTimeApiService {

    // 공통 서비스 키 (Decoding 키 사용 권장)
    private final String KEY = "fa67fab4500ff954472e8a22de42afe98bf413eba38a0fdc515c299cd184a2d8";

    // 💡 createDate 파라미터 추가: 문자가 온 시점의 데이터를 찾기 위함
    public Map<String, String> getExtraData(int catID, String location, String createDate) {
    	
    		System.out.println("====== API 서비스 진입 ======");
        System.out.println("카테고리: " + catID + ", 지역: " + location + ", 날짜: " + createDate);
        
        Map<String, String> result = new HashMap<>();
        try {
            // 날짜 정제 (2026-03-12 -> 20260312)
            String date = (createDate != null && createDate.length() >= 10) 
                          ? createDate.substring(0, 10).replace("-", "") : "";

            switch (catID) {
                case 1: return getForestFireData(location, date); // 산불
                case 2: return getEarthquakeData(date);          // 지진
                case 4: return getWeatherData(location);         // 날씨
                case 6: return getTrafficCctvData(location);     // 교통
                default: return result;
            }
        } catch (Exception e) {
            System.out.println("API 호출 중 오류 발생: " + e.getMessage());
            return result;
        }
    }

    // 1. 산림청 산불 정보 (문자 발생 날짜와 매칭)
    private Map<String, String> getForestFireData(String location, String date) throws Exception {
        Map<String, String> map = new HashMap<>();
        
        String urlStr = "https://apis.data.go.kr/1400000/forestStusService/getffirestatsservice" // 소문자 유지 혹은 공식문서 확인
                + "?ServiceKey=" + KEY // 👈 s를 대문자 S로 변경!
                + "&searchStdt=" + date 
                + "&searchEddt=" + date
                + "&pageNo=1&numOfRows=10&_type=xml";

        System.out.println(">>> 생성된 전체 URL: " + urlStr); // 이 주소를 복사해서 브라우저에 직접 쳐보세요!
        
        String response = fetch(urlStr);
        
        if (response.contains("<item>")) {
            map.put("title", "🌲 산림청 실시간 화재 상세 정보");
            map.put("status", getTagValue(response, "firestatnm")); // 진화 상태
            map.put("cause", getTagValue(response, "firecause"));   // 발생 원인
            map.put("area", getTagValue(response, "firearea") + " ha"); // 피해 면적
            map.put("loc", getTagValue(response, "firelocnm"));    // 상세 장소
        } else {
            map.put("title", "확인된 산불 상세 정보가 없습니다.");
        }
        return map;
    }

    // 2. 기상청 지진 정보 (JSON)
    private Map<String, String> getEarthquakeData(String date) throws Exception {
        Map<String, String> map = new HashMap<>();
        
        // 💡 [해결] 에러가 났던 urlStr 변수를 선언하고 주소를 할당합니다.
        String urlStr = "https://apis.data.go.kr/1360000/EqkInfoService/getEqkMsg"
                      + "?ServiceKey=" + KEY // 상단에 선언한 KEY 변수 사용
                      + "&dataType=JSON&pageNo=1&numOfRows=1&fromTmFc=" + date;

        // 이제 urlStr이 선언되었으므로 fetch 호출이 가능해집니다.
        String response = fetch(urlStr);
        
        map.put("title", "🏠 기상청 실시간 지진 분석 리포트");
        
        // 💡 데이터를 "꽉" 채우기 위한 수동 파싱 (JSON 라이브러리가 없을 때)
        if (response != null && response.contains("\"mt\"")) {
            // mt: 규모, loc: 위치, dep: 깊이 등
            String mt = response.split("\"mt\":")[1].split(",")[0];
            String loc = response.split("\"loc\":")[1].split(",")[0].replace("\"", "");
            String dep = response.split("\"dep\":")[1].split(",")[0];
            
            map.put("magnitude", mt);     // ${extra.magnitude}
            map.put("locationDetail", loc); // ${extra.locationDetail}
            map.put("depth", dep + "km");  // ${extra.depth}
            map.put("status", Double.parseDouble(mt) >= 4.0 ? "주의가 필요한 규모" : "약한 진동 관측");
        }
        
        return map;
    }

    // 3. 기상청 날씨 (기본 구조 유지)
    private Map<String, String> getWeatherData(String location) throws Exception {
        Map<String, String> map = new HashMap<>();
        String urlStr = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
                      + "?ServiceKey=" + KEY + "&dataType=JSON&base_date=20260403&base_time=0500&nx=55&ny=127";

        fetch(urlStr);
        map.put("title", "☀️ 현재 지역 기상 실황");
        map.put("temp", "준비 중");
        return map;
    }

    // 4. 교통 CCTV (기본 구조 유지)
    private Map<String, String> getTrafficCctvData(String location) throws Exception {
        Map<String, String> map = new HashMap<>();
        map.put("title", "사고 인근 실시간 CCTV");
        map.put("cctvUrl", "준비 중"); 
        return map;
    }

    // 공통 네트워크 호출 메서드 (타임아웃 추가로 안정성 강화)
    private String fetch(String urlStr) throws Exception {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(5000); // 5초 대기
        conn.setReadTimeout(5000);
        
        try (BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) sb.append(line);
            return sb.toString();
        } finally {
            conn.disconnect();
        }
    }

    // 💡 불필요한 수정 없이 XML 태그 값을 뽑아내는 도구 메서드
    private String getTagValue(String xml, String tag) {
        try {
            return xml.split("<" + tag + ">")[1].split("</" + tag + ">")[0];
        } catch (Exception e) {
            return "정보 없음";
        }
    }
}