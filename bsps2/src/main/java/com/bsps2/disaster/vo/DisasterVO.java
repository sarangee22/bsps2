package com.bsps2.disaster.vo;

public class DisasterVO {
	// 1. DB 관리용 변수 (Sequence 자동 생성)
	  private long no;             // NO (PK): 시스템 관리 번호
	    private String apiId;        // API_ID: 중복 수집 방지용 고유 번호
	    private int catID;           // CAT_ID: 카테고리 번호 (1~9)
	    private String categoryName; // (JOIN용) 카테고리 한글명 (화재, 지진 등)

	    // 2. 화면 출력 데이터 (스토리보드 기준)
	    private String title;        // TITLE: 재난 제목
	    private String locationName; // LOCATIONNAME: 발생 지역 (REGION)
	    private int dangerLevel;     // DANGERLEVEL: 위험 등급 (1~3)
	    private String createDate;   // CREATEDATE: 발생 일시 (OCCUR_DATE)
	    
	    // 3. 상세 텍스트 데이터 (CLOB 매핑)
	    private String content;      // CONTENT: 상황 요약 및 문자 원문 (SUMMARY)
	    private String detailContent;// DETAILCONTENT: 상세 대처 방법 가이드
	    
	    // 4. 위치 정보
	    private double latitude;     // LATITUDE: 위도
	    private double longitude;    // LONGITUDE: 경도
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
		public int getCatID() {
			return catID;
		}
		public void setCatID(int catID) {
			this.catID = catID;
		}
		public String getCategoryName() {
			return categoryName;
		}
		public void setCategoryName(String categoryName) {
			this.categoryName = categoryName;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
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
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getDetailContent() {
			return detailContent;
		}
		public void setDetailContent(String detailContent) {
			this.detailContent = detailContent;
		}
		public double getLatitude() {
			return latitude;
		}
		public void setLatitude(double latitude) {
			this.latitude = latitude;
		}
		public double getLongitude() {
			return longitude;
		}
		public void setLongitude(double longitude) {
			this.longitude = longitude;
		}
		@Override
		public String toString() {
			return "DisasterVO [no=" + no + ", apiId=" + apiId + ", catID=" + catID + ", categoryName=" + categoryName
					+ ", title=" + title + ", locationName=" + locationName + ", dangerLevel=" + dangerLevel
					+ ", createDate=" + createDate + ", content=" + content + ", detailContent=" + detailContent
					+ ", latitude=" + latitude + ", longitude=" + longitude + "]";
		}
	    
	    
    
}