package com.bsps2.main.item.vo.ItemVO;

public class ItemVO {
	private long no;
	private String id;
	private String name;
	private String category;
	private int quantity;        
	private String unit;         
	private String priority;     
	private String expiryDate;   
	private String memo;
	private String isReady;
	private String regDate;
	private String updateDate;
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public String getId() {
		return id; 
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getExpiryDate() {
		return expiryDate;
	}
	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getIsReady() {
		return isReady;
	}
	public void setIsReady(String isReady) {
		this.isReady = isReady;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	@Override
	public String toString() {
		return "ItemVO [no=" + no + ", id=" + id + ", name=" + name + ", category=" + category + ", quantity="
				+ quantity + ", unit=" + unit + ", priority=" + priority + ", expiryDate=" + expiryDate + ", memo="
				+ memo + ", isReady=" + isReady + ", regDate=" + regDate + ", updateDate=" + updateDate + "]";
	}   
	
	
}
