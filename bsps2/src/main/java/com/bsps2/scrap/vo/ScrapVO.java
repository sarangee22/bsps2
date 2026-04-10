package com.bsps2.scrap.vo;

/**
 * [DISASTER_SCRAP] 테이블과 [DISASTER_LIST] 테이블의 조인 데이터를 담는 객체
 */
public class ScrapVO {

	// 1. DISASTER_SCRAP 테이블 컬럼
    private long scrapNo;      // SCRAP_NO (PK)
    private String id;         // 사용자 아이디
    private long no;           // 재난 정보 번호 (FK)
    private String scrapDate;  // 스크랩 날짜

    // 2. disasterInfo 테이블에서 조인으로 가져올 필드들 (DisasterVO와 필드명 통일)
    private String content;      // disasterInfo의 content (기존 summary)
    private String locationName; // disasterInfo의 locationName (기존 region)
    private int dangerLevel;     // disasterInfo의 dangerLevel (기존 riskGrade)
    private String createDate;   // disasterInfo의 createDate (발생 시각)
	public long getScrapNo() {
		return scrapNo;
	}
	public void setScrapNo(long scrapNo) {
		this.scrapNo = scrapNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public String getScrapDate() {
		return scrapDate;
	}
	public void setScrapDate(String scrapDate) {
		this.scrapDate = scrapDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getLocationName() {
		return locationName;
	}
	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	public int getDangerLevel() {
		return dangerLevel;
	}
	public void setDangerLevel(int dangerLevel) {
		this.dangerLevel = dangerLevel;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "ScrapVO [scrapNo=" + scrapNo + ", id=" + id + ", no=" + no + ", scrapDate=" + scrapDate + ", content="
				+ content + ", locationName=" + locationName + ", dangerLevel=" + dangerLevel + ", createDate="
				+ createDate + "]";
	}
    
    
}