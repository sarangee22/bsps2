package com.bsps2.main.item.vo.ItemVO;

public class ItemVO {
	private long no;
	private String name;
	private String category;
	private String memo;
	private String isReady;
	private String id;
	private String regDate;
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "ItemVO [no=" + no + ", name=" + name + ", category=" + category + ", memo=" + memo + ", isReady="
				+ isReady + ", id=" + id + ", regDate=" + regDate + "]";
	}
	
}
