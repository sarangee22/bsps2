package com.bsps2.scrap.vo;

/**
 * [DISASTER_SCRAP] 테이블과 [DISASTER_LIST] 테이블의 조인 데이터를 담는 객체
 */
public class ScrapVO {

    // 1. DISASTER_SCRAP 테이블 컬럼
    private long scrapNo;    // SCRAP_NO (PK)
    private String id;       // ID (사용자 아이디)
    private long no;         // NO (재난 정보 번호 - FK)
    private String scrapDate; // SCRAP_DATE (스크랩 날짜)

    // 2. DISASTER_LIST 테이블에서 조인으로 가져올 필드들
    private String summary;   // 재난 요약 내용
    private String region;    // 발생 지역
    private int riskGrade;    // 위험 등급 (1: 낮음, 2: 보통, 3: 높음)

    // 기본 생성자 (프레임워크 사용 및 객체 생성을 위해 필수)
    public ScrapVO() {}

    // Getter & Setter
    public long getScrapNo() { return scrapNo; }
    public void setScrapNo(long scrapNo) { this.scrapNo = scrapNo; }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public long getNo() { return no; }
    public void setNo(long no) { this.no = no; }

    public String getScrapDate() { return scrapDate; }
    public void setScrapDate(String scrapDate) { this.scrapDate = scrapDate; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }

    public String getRegion() { return region; }
    public void setRegion(String region) { this.region = region; }

    public int getRiskGrade() { return riskGrade; }
    public void setRiskGrade(int riskGrade) { this.riskGrade = riskGrade; }

    // 데이터 확인용 toString
    @Override
    public String toString() {
        return "ScrapVO [scrapNo=" + scrapNo + ", id=" + id + ", no=" + no 
                + ", scrapDate=" + scrapDate + ", summary=" + summary 
                + ", region=" + region + ", riskGrade=" + riskGrade + "]";
    }
}