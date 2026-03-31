package com.bsps2.disasterMap.ov;

public class DisasterMapVO {
    
    private int rnum; // [필수] 페이징용 순번
    private int disasterId;
    private String disasterName;
    private String disasterType;
    private String region;
    private String address;
    private double latitude;
    private double longitude;
    private String content;
    private String createdAt;

    // rnum Getter/Setter
    public int getRnum() { return rnum; }
    public void setRnum(int rnum) { this.rnum = rnum; }

    // 기존 Getter/Setter들...
    public int getDisasterId() { return disasterId; }
    public void setDisasterId(int disasterId) { this.disasterId = disasterId; }
    public String getDisasterName() { return disasterName; }
    public void setDisasterName(String disasterName) { this.disasterName = disasterName; }
    public String getDisasterType() { return disasterType; }
    public void setDisasterType(String disasterType) { this.disasterType = disasterType; }
    public String getRegion() { return region; }
    public void setRegion(String region) { this.region = region; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }
    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "DisasterMapVO [rnum=" + rnum + ", disasterId=" + disasterId + ", disasterName=" + disasterName + "]";
    }
}