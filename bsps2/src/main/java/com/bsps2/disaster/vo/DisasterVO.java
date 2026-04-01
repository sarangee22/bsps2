package com.bsps2.disaster.vo;

public class DisasterVO {
	// 1. DB 관리용 변수 (Sequence 자동 생성)
    private long no;        // PK: DB에서 자동으로 매길 번호 (Sequence/AI)

    // 2. 공공 API에서 직접 읽어올 변수 (원문 데이터)
    private String apiId;           // API가 제공하는 고유 번호 (중복 체크용)
    private String content;         // 재난 문자 원문 (이걸 분석해서 카테고리 나눔)
    private String locationName;    // 발생 지역 (서울, 부산 등)
    private String createDate;      // 발생/발송 일시 (문자열로 받는 것이 편리함)

    // 3. Java 로직(for문)을 통해 가공해서 넣을 변수
    private int catID;
    private String category;        // 재난 종류 (fire, earthquake, flood 등)
    private String categoryName;    // 화면 표시용 한글 이름 (화재, 지진 등)
    private int dangerLevel;        // 위험 등급 (1: 정보, 2: 주의, 3: 경보 등)
    
    private String detailContent; // DISASTER_DETAIL 테이블의 content
    private String actionGuide;   // DISASTER_DETAIL 테이블의 action_guide
    
    private String detailInfo;    // DETAIL_INFO 컬럼용
    private String situationDesc; // SITUATION_DESC 컬럼용
    private String mapLocation;   // MAP_LOCATION 컬럼용
    
    
	public String getDetailInfo() {
		return detailInfo;
	}
	public void setDetailInfo(String detailInfo) {
		this.detailInfo = detailInfo;
	}
	public String getSituationDesc() {
		return situationDesc;
	}
	public void setSituationDesc(String situationDesc) {
		this.situationDesc = situationDesc;
	}
	public String getMapLocation() {
		return mapLocation;
	}
	public void setMapLocation(String mapLocation) {
		this.mapLocation = mapLocation;
	}
	public String getDetailContent() {
		return detailContent;
	}
	public void setDetailContent(String detailContent) {
		this.detailContent = detailContent;
	}
	public String getActionGuide() {
		return actionGuide;
	}
	public void setActionGuide(String actionGuide) {
		this.actionGuide = actionGuide;
	}
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public String getApiId() {
		return apiId;
	}
	public void setApiId(String apiId) {
		this.apiId = apiId;
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
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public int getCatID() {
		return catID;
	}
	public void setCatID(int catID) {
		this.catID = catID;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getDangerLevel() {
		return dangerLevel;
	}
	public void setDangerLevel(int dangerLevel) {
		this.dangerLevel = dangerLevel;
	}
	@Override
	public String toString() {
		return "DisasterVO [no=" + no + ", apiId=" + apiId + ", content=" + content + ", locationName=" + locationName
				+ ", createDate=" + createDate + ", catID=" + catID + ", category=" + category + ", categoryName="
				+ categoryName + ", dangerLevel=" + dangerLevel + ", detailContent=" + detailContent + ", actionGuide="
				+ actionGuide + ", detailInfo=" + detailInfo + ", situationDesc=" + situationDesc + ", mapLocation="
				+ mapLocation + "]";
	}
	
	
    
    
}