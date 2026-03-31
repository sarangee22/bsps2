package com.bsps2.disasterSafe.vo;

public class AgencyVO {
    
    // 1. private 필드 선언 (rnum 추가 및 언더바 제거)
    private int rnum;            // 페이징용 번호
    private int agencyId;        // 기관 ID
    private String agencyName;   // 기관명
    private String agencyType;   // 기관유형
    private String phone;        // 전화번호
    private String address;      // 주소
    private double latitude;     // 위도
    private double longitude;    // 경도
    private String operatingHours; // 운영시간

    // 2. Getter & Setter (데이터를 넣고 빼는 통로)
    public int getRnum() {
        return rnum;
    }
    public void setRnum(int rnum) {
        this.rnum = rnum;
    }
    public int getAgencyId() {
        return agencyId;
    }
    public void setAgencyId(int agencyId) {
        this.agencyId = agencyId;
    }
    public String getAgencyName() {
        return agencyName;
    }
    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }
    public String getAgencyType() {
        return agencyType;
    }
    public void setAgencyType(String agencyType) {
        this.agencyType = agencyType;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
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
    public String getOperatingHours() {
        return operatingHours;
    }
    public void setOperatingHours(String operatingHours) {
        this.operatingHours = operatingHours;
    }

    // 3. toString (데이터 확인용)
    @Override
    public String toString() {
        return "AgencyVO [rnum=" + rnum + ", agencyId=" + agencyId + ", agencyName=" + agencyName + ", agencyType="
                + agencyType + ", phone=" + phone + ", address=" + address + ", latitude=" + latitude + ", longitude="
                + longitude + ", operatingHours=" + operatingHours + "]";
    }
}